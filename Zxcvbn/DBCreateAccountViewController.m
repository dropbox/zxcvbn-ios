//
//  DBCreateAccountViewController.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/22/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBCreateAccountViewController.h"

#import "DBPasswordStrengthMeterView.h"

@interface DBCreateAccountViewController ()

@property (weak, nonatomic) IBOutlet DBPasswordStrengthMeterView *passwordStrengthMeterView;

@end

@implementation DBCreateAccountViewController

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *password = [textField.text stringByReplacingCharactersInRange:range withString:string];

    [self.passwordStrengthMeterView scorePassword:password];

    return YES;
}

@end
