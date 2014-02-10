//
//  DBMatcher.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBMatcher.h"

typedef NSArray* (^MatcherBlock)(NSString *password);

@interface DBMatcher ()

@property (nonatomic, strong) NSMutableArray *dictionaryMatchers;

@end

@implementation DBMatcher

- (id)init
{
    self = [super init];

    if (self != nil) {
        self.dictionaryMatchers = [[NSMutableArray alloc] init];

        [self loadFrequencyLists];
    }

    return self;
}

- (NSArray *)omnimatch:(NSString *)password
{
    NSMutableArray *matches = [[NSMutableArray alloc] init];

    for (MatcherBlock matcher in self.dictionaryMatchers) {
        [matches addObjectsFromArray:matcher(password)];
    }

    // TODO: sort

    return matches;
}

- (NSMutableArray *)dictionaryMatch:(NSString *)password rankedDict:(NSMutableDictionary *)rankedDict
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int length = [password length];
    NSString *passwordLower = [password lowercaseString];

    for (int i = 0; i < length; i++) {
        for (int j = i; j < length; j++) {
            NSString *word = [passwordLower substringWithRange:NSMakeRange(i, j-i)];
            NSNumber *rank = [rankedDict objectForKey:word];

            if (rank != nil) {
                NSDictionary *dict =  @{
                                        @"pattern": @"dictionary",
                                        @"i": [NSNumber numberWithInt:i],
                                        @"j": [NSNumber numberWithInt:j],
                                        @"token": [password substringWithRange:NSMakeRange(i, j-i)],
                                        @"matched_word": word,
                                        @"rank": rank
                                        };
                [result addObject:[[NSMutableDictionary alloc] initWithDictionary:dict]];
            }
        }
    }

    return result;
}

- (NSMutableDictionary *)buildRankedDict:(NSArray *)unrankedList
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    int i = 1; // rank starts at 1, not 0

    for (NSString *word in unrankedList) {
        [result setObject:[NSNumber numberWithInt:i] forKey:word];
        i++;
    }

    return result;
}

- (MatcherBlock)buildDictMatcher:(NSString *)dictName rankedDict:(NSMutableDictionary *)rankedDict
{
    MatcherBlock block = ^ NSArray* (NSString *password) {

        NSMutableArray *matches = [self dictionaryMatch:password rankedDict:rankedDict];

        for (NSMutableDictionary *match in matches) {
            [match setObject:dictName forKey:@"dictionary_name"];
        }

        return matches;
    };

    return block;
}

- (void)loadFrequencyLists
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"frequency_lists" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];

    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

    if (error == nil) {
        for (NSString *dictName in (NSDictionary *)json) {
            
            NSArray *wordList = [(NSDictionary *)json objectForKey:dictName];
            NSMutableDictionary *rankedDict = [self buildRankedDict:wordList];

            [self.dictionaryMatchers addObject:[self buildDictMatcher:dictName rankedDict:rankedDict]];
        }
    } else {
        NSLog(@"Error parsing frequency lists: %@", error);
    }
}

@end
