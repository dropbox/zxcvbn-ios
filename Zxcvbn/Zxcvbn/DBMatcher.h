//
//  DBMatcher.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DBMatcherMatchPatternDictionary,
} DBMatcherMatchPattern;

@interface DBMatcher : NSObject

- (NSArray *)omnimatch:(NSString *)password;

@end
