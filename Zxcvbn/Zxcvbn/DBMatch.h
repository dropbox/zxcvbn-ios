//
//  DBMatch.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/10/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DBMatchPatternDictionary,
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

@property (nonatomic, assign) int cardinality;
@property (nonatomic, assign) float entropy;
@property (nonatomic, assign) float baseEntropy;
@property (nonatomic, assign) float upperCaseEntropy;
@property (nonatomic, assign) float l33tEntropy;

- (NSString *)patternString;

@end
