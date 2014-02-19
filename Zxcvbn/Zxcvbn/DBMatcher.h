//
//  DBMatcher.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

@interface DBMatcher : NSObject

- (NSArray *)omnimatch:(NSString *)password;

@end


typedef enum {
    DBMatchPatternDictionary = 0,
    DBMatchPatternBruteforce,
} DBMatchPattern;

@interface DBMatch : NSObject

@property (nonatomic, assign) DBMatchPattern pattern;
@property (nonatomic, assign) int i;
@property (nonatomic, assign) int j;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *matchedWord;
@property (nonatomic, assign) int rank;
@property (strong, nonatomic) NSString *dictionaryName;
@property (nonatomic, assign) BOOL l33t;
@property (strong, nonatomic) NSDictionary *sub;
@property (nonatomic, assign) int cardinality;
@property (nonatomic, assign) float entropy;
@property (nonatomic, assign) float baseEntropy;
@property (nonatomic, assign) float upperCaseEntropy;
@property (nonatomic, assign) int l33tEntropy;
@property (strong, nonatomic) NSString *subDisplay;

- (NSString *)patternString;

@end