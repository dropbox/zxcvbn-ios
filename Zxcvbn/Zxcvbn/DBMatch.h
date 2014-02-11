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
} DBMatchPattern;

@interface DBMatch : NSObject

@property (nonatomic, assign) DBMatchPattern pattern;
@property (nonatomic, assign) int i;
@property (nonatomic, assign) int j;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *matchedWord;
@property (nonatomic, assign) int rank;
@property (strong, nonatomic) NSString *dictionaryName;

@property (nonatomic, assign) int entropy;
@property (nonatomic, assign) int baseEntropy;
@property (nonatomic, assign) int upperCaseEntropy;
@property (nonatomic, assign) int l33tEntropy;

@end
