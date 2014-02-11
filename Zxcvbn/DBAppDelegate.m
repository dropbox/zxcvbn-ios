//
//  DBAppDelegate.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBAppDelegate.h"

#import "DBZxcvbn.h"

@implementation DBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBZxcvbn *zxcvbn = [[DBZxcvbn alloc] init];

    NSArray *testPasswords = @[
                               @"zxcvbn",
                               @"qwER43@!",
                               @"Tr0ub4dour&3",
                               @"correcthorsebatterystaple",
                               @"coRrecth0rseba++ery9.23.2007staple$",

                               @"D0g..................",
                               @"abcdefghijk987654321",
                               @"neverforget13/3/1997",
                               @"1qaz2wsx3edc",

                               @"temppass22",
                               @"briansmith",
                               @"briansmith4mayor",
                               @"password1",
                               @"viking",
                               @"thx1138",
                               @"ScoRpi0ns",
                               @"do you know",
                               
                               @"ryanhunter2000",
                               @"rianhunter2000",
                               
                               @"asdfghju7654rewq",
                               @"AOEUIDHG&*()LS_",
                               
                               @"12345678",
                               @"defghi6789",
                               
                               @"rosebud",
                               @"Rosebud",
                               @"ROSEBUD",
                               @"rosebuD",
                               @"ros3bud99",
                               @"r0s3bud99",
                               @"R0$38uD99",
                               
                               @"verlineVANDERMARK",
                               
                               @"eheuczkqyq",
                               @"rWibMFACxAUGZmxhVncy",
                               @"Ba9ZyWABu99[BK#6MBgbH88Tofv)vs$w",
                               ];

    for (NSString *password in testPasswords) {

        DBResult *result = [zxcvbn passwordStrength:password];

        NSLog(@"password: %@", result.password);
        NSLog(@"entropy: %f", result.entropy);
        NSLog(@"crack time (seconds): %f", result.crackTime);
        //crack time (display):	instant
        //score from 0 to 4:	0
        //calculation time (ms):	7

        NSLog(@"\n");
        NSLog(@"match sequence:");
        for (DBMatch *match in result.matchSequence) {
            NSLog(@"\n");
            NSLog(@"'%@'", match.token);
            NSLog(@"pattern: %@", [match patternString]);
            NSLog(@"entropy: %f", match.entropy);
            if (match.dictionaryName)
                NSLog(@"dict-name: %@", match.dictionaryName);
            if (match.rank)
                NSLog(@"rank: %d", match.rank);
            if (match.baseEntropy)
                NSLog(@"base-entropy: %f", match.baseEntropy);
            if (match.upperCaseEntropy)
                NSLog(@"upper-entropy: %f", match.upperCaseEntropy);
            if (match.cardinality)
                NSLog(@"cardinality: %d", match.cardinality);
        }

        NSLog(@"\n\n");
    }

    return YES;
}

@end
