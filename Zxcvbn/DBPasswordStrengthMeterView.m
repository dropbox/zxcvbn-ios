//
//  DBPasswordStrengthMeterView.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/22/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBPasswordStrengthMeterView.h"

#import "DBZxcvbn.h"

@interface DBPasswordStrengthMeterView ()

@property (nonatomic, strong) DBZxcvbn *zxcvbn;

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *view4;
@property (nonatomic, strong) NSArray *meterViews;

@property (nonatomic, strong) UIColor *lightColor;
@property (nonatomic, strong) UIColor *darkColor;

@end

@implementation DBPasswordStrengthMeterView

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0, 0.0, 8.0, 30.0)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [self sharedInit];
}

- (void)sharedInit
{
    self.zxcvbn = [[DBZxcvbn alloc] init];

    float unitHeight = 6.0;
    float padding = 2.0;
    float width = self.frame.size.width;

    self.lightColor = [UIColor colorWithRed:204.0/255.0 green:230.0/255.0 blue:249.0/255.0 alpha:1.0];
    self.darkColor = [UIColor colorWithRed:64.0/255.0 green:147.0/255.0 blue:224.0/255.0 alpha:1.0];

    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - unitHeight, width, unitHeight)];
    self.view1.backgroundColor = self.lightColor;
    [self addSubview:self.view1];

    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - (unitHeight * 2 + padding), width, unitHeight)];
    self.view2.backgroundColor = self.lightColor;
    [self addSubview:self.view2];

    self.view3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - (unitHeight * 3 + padding * 2), width, unitHeight)];
    self.view3.backgroundColor = self.lightColor;
    [self addSubview:self.view3];

    self.view4 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - (unitHeight * 4 + padding * 3), width, unitHeight)];
    self.view4.backgroundColor = self.lightColor;
    [self addSubview:self.view4];

    self.meterViews = @[self.view1, self.view2, self.view3, self.view4];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(strengthMeterTapped:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)strengthMeterTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(passwordStrengthMeterViewTapped:)]) {
        [self.delegate passwordStrengthMeterViewTapped:self];
    }
}

- (void)setLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor
{
    self.lightColor = lightColor;
    self.darkColor = darkColor;

    for (UIView *view in self.meterViews) {
        view.backgroundColor = lightColor;
    }
}

- (void)scorePassword:(NSString *)password
{
    [self scorePassword:password userInputs:nil];
}

- (void)scorePassword:(NSString *)password userInputs:(NSArray *)userInputs
{
    int score = [self.zxcvbn passwordStrength:password userInputs:userInputs].score;

    for (int i = 0; i < [self.meterViews count]; i++) {
        UIView *meterView = [self.meterViews objectAtIndex:i];
        meterView.backgroundColor = i < score ? self.darkColor : self.lightColor;
    }
}

@end
