//
//  DBMatcher.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

@interface DBMatcher : NSObject

@property (nonatomic, assign) int keyboardAverageDegree;
@property (nonatomic, assign) int keypadAverageDegree;
@property (nonatomic, assign) int keyboardStartingPositions;
@property (nonatomic, assign) int keypadStartingPositions;

- (NSArray *)omnimatch:(NSString *)password;

@end

@interface DBMatch : NSObject

@property (nonatomic, assign) NSString *pattern;
@property (strong, nonatomic) NSString *token;
@property (nonatomic, assign) int i;
@property (nonatomic, assign) int j;
@property (nonatomic, assign) float entropy;
@property (nonatomic, assign) int cardinality;

// Dictionary
@property (strong, nonatomic) NSString *matchedWord;
@property (strong, nonatomic) NSString *dictionaryName;
@property (nonatomic, assign) int rank;
@property (nonatomic, assign) float baseEntropy;
@property (nonatomic, assign) float upperCaseEntropy;

// l33t
@property (nonatomic, assign) BOOL l33t;
@property (strong, nonatomic) NSDictionary *sub;
@property (strong, nonatomic) NSString *subDisplay;
@property (nonatomic, assign) int l33tEntropy;

// Spatial
@property (strong, nonatomic) NSString *graph;
@property (nonatomic, assign) int turns;
@property (nonatomic, assign) int shiftedCount;

// Repeat
@property (strong, nonatomic) NSString *repeatedChar;

// Sequence
@property (strong, nonatomic) NSString *sequenceName;
@property (nonatomic, assign) int sequenceSpace;
@property (nonatomic, assign) BOOL ascending;

@end