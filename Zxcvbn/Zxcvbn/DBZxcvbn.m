//
//  DBZxcvbn.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBZxcvbn.h"

@interface DBZxcvbn ()

@property (nonatomic, strong) DBMatcher *matcher;
@property (nonatomic, strong) DBScorer *scorer;

@end

@implementation DBZxcvbn

- (id)init
{
    self = [super init];

    if (self != nil) {
        self.matcher = [[DBMatcher alloc] init];
        self.scorer = [[DBScorer alloc] init];
    }

    return self;
}

- (DBResult *)passwordStrength:(NSString *)password
{
    return [self passwordStrength:password userInputs:nil];
}

- (DBResult *)passwordStrength:(NSString *)password userInputs:(NSArray *)userInputs
{
    NSDate *start = [NSDate date];
    NSArray *matches = [self.matcher omnimatch:password userInputs:userInputs];
    DBResult *result = [self.scorer minimumEntropyMatchSequence:password matches:matches];
    result.calcTime = [[NSDate date] timeIntervalSinceDate:start] * 1000;
    return result;
}

@end
