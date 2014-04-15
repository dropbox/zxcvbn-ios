//
//  DBPasswordStrengthMeterView.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/22/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DBPasswordStrengthMeterViewDelegate;

@interface DBPasswordStrengthMeterView : UIView

@property (nonatomic, assign) id <DBPasswordStrengthMeterViewDelegate> delegate;

- (void)setLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;
- (void)scorePassword:(NSString *)password;
- (void)scorePassword:(NSString *)password userInputs:(NSArray *)userInputs;

@end

@protocol DBPasswordStrengthMeterViewDelegate <NSObject>

- (void)passwordStrengthMeterViewTapped:(DBPasswordStrengthMeterView *)passwordStrengthMeterView;

@end
