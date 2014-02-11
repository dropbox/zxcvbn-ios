//
//  DBMatch.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/10/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBMatch.h"

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
