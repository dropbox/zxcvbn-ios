//
//  DBPasswordStrengthMeterView.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/22/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBPasswordStrengthMeterView : UIView

- (void)setLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;
- (void)scorePassword:(NSString *)password;

@end
