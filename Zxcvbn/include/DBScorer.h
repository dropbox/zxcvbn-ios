//
//  DBScorer.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBResult;

@interface DBScorer : NSObject

- (DBResult *)minimumEntropyMatchSequence:(NSString *)password matches:(NSArray *)matches;

@end


@interface DBResult : NSObject

@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *entropy; // bits
@property (strong, nonatomic) NSString *crackTime; // estimation of actual crack time, in seconds.
@property (strong, nonatomic) NSString *crackTimeDisplay; // same crack time, as a friendlier string: "instant", "6 minutes", "centuries", etc.
@property (nonatomic, assign) int score; // [0,1,2,3,4] if crack time is less than [10**2, 10**4, 10**6, 10**8, Infinity]. (useful for implementing a strength bar.)
@property (strong, nonatomic) NSArray *matchSequence; // the list of patterns that zxcvbn based the entropy calculation on.
@property (nonatomic, assign) float calcTime; // how long it took to calculate an answer, in milliseconds. usually only a few ms.

@end