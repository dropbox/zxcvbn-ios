//
//  DBScorer.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBScorer.h"

#import "DBMatcher.h"
#import "DBResult.h"

@implementation DBScorer

- (DBResult *)minimumEntropyMatchSequence:(NSString *)password matches:(NSArray *)matches
{
    /* minimum entropy search
     
     takes a list of overlapping matches, returns the non-overlapping sublist with
     minimum entropy. O(nm) dp alg for length-n password with m candidate matches.
     */
    
    int bruteforceCardinality = [self calcBruteforceCardinality:password];
    NSLog(@"%d", bruteforceCardinality);
    
    NSMutableArray *upToK = [[NSMutableArray alloc] init]; // minimum entropy up to k.
    NSMutableArray *backpointers = [[NSMutableArray alloc] init]; // for the optimal sequence of matches up to k, holds the final match (match.j == k). null means the sequence ends w/ a brute-force character.
    
    for (int k = 0; k < [password length]; k++) {
        // starting scenario to try and beat: adding a brute-force character to the minimum entropy sequence at k-1.
        [upToK insertObject:[NSNumber numberWithInt:[get(upToK, k-1) intValue] + lg(bruteforceCardinality)] atIndex:k];
        [backpointers insertObject:[NSNull null] atIndex:k];
        for (NSDictionary *match in matches) {
            int i = [[match objectForKey:@"i"] intValue];
            int j = [[match objectForKey:@"j"] intValue];
            if (j != k) {
                continue;
            }
            // see if best entropy up to i-1 + entropy of this match is less than the current minimum at j.
            int candidateEntropy = [get(upToK, i-1) intValue] + [self calcEntropy:match];

            
            
        }

    }
    
    // final result object
    DBResult *result = [[DBResult alloc] init];
    result.password = password;
    return result;
}

- (int)calcBruteforceCardinality:(NSString *)password
{
    int digits = 0;
    int upper = 0;
    int lower = 0;
    int symbols = 0;
    
    NSUInteger length = [password length];
    unichar buffer[length];
    [password getCharacters:buffer range:NSMakeRange(0, length)];
    
    for (NSUInteger i = 0; i < length; i++) {
        unichar chr = buffer[i];
        
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:chr]) {
            digits = 10;
        } else if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:chr]) {
            upper = 26;
        } else if ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:chr]) {
            upper = 26;
        } else {
            symbols = 33;
        }
    }
    
    return digits + upper + lower + symbols;
}

#pragma mark - Helpers

float lg(float n)
{
    return log10f(n) / log10f(2);
}

id get(NSArray *a, int i)
{
    if (i < 0 || i >= [a count]) {
        return 0;
    }
    return a[i];
}

#pragma mark - Entropy calcs
#pragma -- one function per match pattern

- (int)calcEntropy:(NSMutableDictionary *)match
{
    if ([match objectForKey:@"entropy"]) {
        // a match's entropy doesn't change. cache it.
        return [[match objectForKey:@"entropy"] intValue];
    }
    
    int entropy = 0;
    switch ([[match objectForKey:@"pattern"] intValue]) {
        case DBMatcherMatchPatternDictionary:
            entropy = [self dictionaryEntropy:match];
            break;
        
        default:
            break;
    }
    
    [match setObject:[NSNumber numberWithInt:entropy] forKey:@"entropy"];
    NSLog(@"matched word: %@", [match objectForKey:@"matched_word"]);
    NSLog(@"entropy: %d", entropy);
    return entropy;
}

- (int)dictionaryEntropy:(NSMutableDictionary *)match
{
    int baseEntropy = lg([[match objectForKey:@"rank"] intValue]); // keep these as properties for display purposes
    [match setObject:[NSNumber numberWithInt:baseEntropy] forKey:@"base_entropy"];
    int upperCaseEntropy = [self extraUppercaseEntropy:match];
    [match setObject:[NSNumber numberWithInt:upperCaseEntropy] forKey:@"uppercase_entropy"];
    //match.l33t_entropy = extra_l33t_entropy match
    //match.base_entropy + match.uppercase_entropy + match.l33t_entropy
    return baseEntropy + upperCaseEntropy;
}

-(int)extraUppercaseEntropy:(NSMutableDictionary *)match
{
    NSString *word = [match objectForKey:@"token"];
    
    return 0;
}

@end
