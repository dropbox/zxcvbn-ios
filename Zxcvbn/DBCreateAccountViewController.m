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

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
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

    [self.passwordStrengthMeterView scorePassword:password userInputs:@[self.firstNameTextField.text,
                                                                        self.lastNameTextField.text,
                                                                        self.emailTextField.text]];

    return YES;
}

- (void)passwordStrengthMeterViewTapped:(DBPasswordStrengthMeterView *)passwordStrengthMeterView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"Good passwords are hard to guess. Use uncommon words or inside jokes, non-standard uPPercasing, creative spelling, and non-obvious numbers and symbols."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
