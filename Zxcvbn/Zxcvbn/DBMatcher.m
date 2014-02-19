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

@property (nonatomic, strong) NSArray *dictionaryMatchers;
@property (nonatomic, strong) NSMutableArray *matchers;

@end

@implementation DBMatcher

- (id)init
{
    self = [super init];

    if (self != nil) {
        self.dictionaryMatchers = [self loadFrequencyLists];

        self.matchers = [[NSMutableArray alloc] initWithArray:self.dictionaryMatchers];
        [self.matchers addObject:[self l33tMatch]];
    }

    return self;
}

#pragma mark - omnimatch -- combine everything

- (NSArray *)omnimatch:(NSString *)password
{
    NSMutableArray *matches = [[NSMutableArray alloc] init];

    for (MatcherBlock matcher in self.matchers) {
        [matches addObjectsFromArray:matcher(password)];
    }

    return [matches sortedArrayUsingDescriptors: @[[[NSSortDescriptor alloc] initWithKey:@"i" ascending:YES],
                                                   [[NSSortDescriptor alloc] initWithKey:@"j" ascending:YES]]];
}

#pragma mark - dictionary match (common passwords, english, last names, etc)

- (NSMutableArray *)dictionaryMatch:(NSString *)password rankedDict:(NSMutableDictionary *)rankedDict
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int length = [password length];
    NSString *passwordLower = [password lowercaseString];

    for (int i = 0; i < length; i++) {
        for (int j = i; j < length; j++) {
            NSString *word = [passwordLower substringWithRange:NSMakeRange(i, j - i + 1)];
            NSNumber *rank = [rankedDict objectForKey:word];

            if (rank != nil) {
                DBMatch *match = [[DBMatch alloc] init];
                match.pattern = DBMatchPatternDictionary;
                match.i = i;
                match.j = j;
                match.token = [password substringWithRange:NSMakeRange(i, j - i + 1)];
                match.matchedWord = word;
                match.rank = [rank intValue];
                [result addObject:match];
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
        
        for (DBMatch *match in matches) {
            match.dictionaryName = dictName;
        }

        return matches;
    };

    return block;
}

- (NSArray *)loadFrequencyLists
{
    NSMutableArray *dictionaryMatchers = [[NSMutableArray alloc] init];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"frequency_lists" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];

    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

    if (error == nil) {
        for (NSString *dictName in (NSDictionary *)json) {
            
            NSArray *wordList = [(NSDictionary *)json objectForKey:dictName];
            NSMutableDictionary *rankedDict = [self buildRankedDict:wordList];

            [dictionaryMatchers addObject:[self buildDictMatcher:dictName rankedDict:rankedDict]];
        }
    } else {
        NSLog(@"Error parsing frequency lists: %@", error);
    }

    return dictionaryMatchers;
}

#pragma mark - dictionary match with common l33t substitutions

- (NSDictionary *)l33tTable
{
    return @{
             @"a": @[@"4", @"@"],
             @"b": @[@"8"],
             @"c": @[@"(", @"{", @"[", @"<"],
             @"e": @[@"3"],
             @"g": @[@"6", @"9"],
             @"i": @[@"1", @"!", @"|"],
             @"l": @[@"1", @"|", @"7"],
             @"o": @[@"0"],
             @"s": @[@"$", @"5"],
             @"t": @[@"+", @"7"],
             @"x": @[@"%"],
             @"z": @[@"2"],
             };
}

- (NSDictionary *)relevantL33tSubtable:(NSString *)password
{
    // makes a pruned copy of l33t_table that only includes password's possible substitutions
    NSMutableDictionary *filtered = [[NSMutableDictionary alloc] init];

    for (NSString *letter in [[self l33tTable] allKeys]) {
        NSArray *subs = [[self l33tTable] objectForKey:letter];
        NSMutableArray *relevantSubs = [[NSMutableArray alloc] initWithCapacity:[subs count]];
        for (NSString *sub in subs) {
            if ([password rangeOfString:sub].location != NSNotFound) {
                [relevantSubs addObject:sub];
            }
        }
        if ([relevantSubs count] > 0) {
            [filtered setObject:relevantSubs forKey:letter];
        }
    }

    return filtered;
}

- (NSArray *)enumerateL33tSubs:(NSDictionary *)table
{
    // returns the list of possible 1337 replacement dictionaries for a given password
    NSMutableArray *subs = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] init], nil];

    NSMutableArray* (^dedup)(NSArray *) = ^ NSMutableArray* (NSArray *subs) {
        //NSMutableArray *deduped = [[NSMutableArray alloc] init];
        for (NSArray *sub in subs) {
            // TODO implement this
        }
        return [[NSMutableArray alloc] initWithArray:subs]; // temp
    };

    NSArray *keys = [table allKeys];

    while ([keys count] > 0) {
        NSString *firstKey = [keys objectAtIndex:0];
        NSArray *restKeys = [keys count] > 1 ? [keys subarrayWithRange:NSMakeRange(1, [keys count] - 1)] : @[];
        NSMutableArray *nextSubs = [[NSMutableArray alloc] init];

        for (NSString *l33tChr in (NSArray *)[table objectForKey:firstKey]) {
            for (NSMutableArray *sub in subs) {

                int dupL33tIndex = -1;
                for (int i = 0; i < [sub count]; i++) {
                    if ([[[sub objectAtIndex:i] objectAtIndex:0] isEqualToString:l33tChr]) {
                        dupL33tIndex = i;
                        break;
                    }
                }

                if (dupL33tIndex == -1) {
                    NSMutableArray *subExtension = [[NSMutableArray alloc] initWithArray:sub];
                    [subExtension addObject:@[l33tChr, firstKey]];
                    [nextSubs addObject:subExtension];
                } else {
                    NSMutableArray *subAlternative = [[NSMutableArray alloc] initWithArray:sub];
                    [subAlternative removeObjectAtIndex:dupL33tIndex];
                    [subAlternative addObject:@[l33tChr, firstKey]];
                    [nextSubs addObject:sub];
                    [nextSubs addObject:subAlternative];
                }
            }
        }

        subs = dedup(nextSubs);
        keys = restKeys;
    }

    NSMutableArray *subDicts = [[NSMutableArray alloc] init]; // convert from assoc lists to dicts
    for (NSMutableArray *sub in subs) {
        NSMutableDictionary *subDict = [[NSMutableDictionary alloc] initWithCapacity:[sub count]];
        for (NSArray *pair in sub) {
            [subDict setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
        }
        [subDicts addObject:subDict];
    }
    return subDicts;
}

- (MatcherBlock)l33tMatch
{
    MatcherBlock block = ^ NSArray* (NSString *password) {

        NSMutableArray *matches = [[NSMutableArray alloc] init];

        for (NSDictionary *sub in [self enumerateL33tSubs:[self relevantL33tSubtable:password]]) {
            if ([sub count] == 0) { break; } // corner case: password has no relevent subs.

            NSString *subbedPassword = [self translate:password characterMap:sub];

            for (MatcherBlock matcher in self.dictionaryMatchers) {
                for (DBMatch *match in matcher(subbedPassword)) {

                    NSString *token = [password substringWithRange:NSMakeRange(match.i, match.j - match.i + 1)];
                    if ([[token lowercaseString] isEqualToString:match.matchedWord]) {
                        continue; // only return the matches that contain an actual substitution
                    }

                    NSMutableDictionary *matchSub = [[NSMutableDictionary alloc] init]; // subset of mappings in sub that are in use for this match
                    NSMutableArray *subDisplay = [[NSMutableArray alloc] init];
                    for (NSString *subbedChr in [sub allKeys]) {
                        NSString *chr = [sub objectForKey:subbedChr];
                        if ([token rangeOfString:subbedChr].location != NSNotFound) {
                            [matchSub setObject:chr forKey:subbedChr];
                            [subDisplay addObject:[NSString stringWithFormat:@"%@ -> %@", chr, subbedChr]];
                        }
                    }

                    match.l33t = YES;
                    match.token = token;
                    match.sub = matchSub;
                    match.subDisplay = [subDisplay componentsJoinedByString:@","];
                    [matches addObject:match];
                }
            }
        }

        return matches;
    };

    return block;
}

#pragma mark - utilities

- (NSString *)translate:(NSString *)string characterMap:(NSDictionary *)chrMap
{
    for (NSString *key in [chrMap allKeys]) {
        string = [string stringByReplacingOccurrencesOfString:key withString:[chrMap objectForKey:key]];
    }
    return string;
}

@end


@implementation DBMatch

- (NSString *)patternString
{
    NSArray *patterns = @[
                          @"dictionary",
                          @"bruteforce"
                          ];
    return [patterns objectAtIndex:self.pattern];
}

@end
