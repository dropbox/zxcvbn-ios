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
        NSLog(@"score from 0 to 4: %d", result.score);
        //calculation time (ms):	7

        NSLog(@"\n");
        NSLog(@"match sequence:");

        for (DBMatch *match in result.matchSequence) {

            NSLog(@"\n");
            NSLog(@"'%@'", match.token);
            NSLog(@"pattern: %@", match.pattern);
            NSLog(@"entropy: %f", match.entropy);

            if ([match.pattern isEqualToString:@"dictionary"]) {
                NSLog(@"dict-name: %@", match.dictionaryName);
                NSLog(@"rank: %d", match.rank);
                NSLog(@"base-entropy: %f", match.baseEntropy);
                NSLog(@"upper-entropy: %f", match.upperCaseEntropy);
            }

            if ([match.pattern isEqualToString:@"bruteforce"]) {
                NSLog(@"cardinality: %d", match.cardinality);
            }

            if (match.l33t) {
                NSLog(@"l33t-entropy: %d", match.l33tEntropy);
                NSLog(@"l33t subs: %@", match.subDisplay);
                NSLog(@"un-l33ted: %@", match.matchedWord);
            }

            if ([match.pattern isEqualToString:@"spatial"]) {
                NSLog(@"graph: %@", match.graph);
                NSLog(@"turns: %d", match.turns);
                NSLog(@"shifted keys: %d", match.shiftedCount);
            }

            if ([match.pattern isEqualToString:@"repeat"]) {
                NSLog(@"repeat-char: '%@'", match.repeatedChar);
            }
        }

        NSLog(@"\n\n");
    }

    return YES;
}

@end
