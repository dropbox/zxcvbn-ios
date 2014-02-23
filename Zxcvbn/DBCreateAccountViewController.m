//
//  DBCreateAccountViewController.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/22/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBCreateAccountViewController.h"

#import "DBPasswordStrengthMeterView.h"

@interface DBCreateAccountViewController () <DBPasswordStrengthMeterViewDelegate>

@property (weak, nonatomic) IBOutlet DBPasswordStrengthMeterView *passwordStrengthMeterView;

@end

@implementation DBCreateAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.passwordStrengthMeterView.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *password = [textField.text stringByReplacingCharactersInRange:range withString:string];

    [self.passwordStrengthMeterView scorePassword:password];

    return YES;
}

- (void)passwordStrengthMeterViewTapped:(DBPasswordStrengthMeterView *)passwordStrengthMeterView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Good passwords are hard to guess. Use uncommon words or inside jokes, non-standard uPPercasing, creative spelling, and non-obvious numbers and symbols." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    [alertView show];
}

@end
