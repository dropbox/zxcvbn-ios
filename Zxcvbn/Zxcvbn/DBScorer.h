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
