//
//  OLSignInController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLSignInController.h"
#import "AppDelegate.h"

@interface OLSignInController ()

@end

@implementation OLSignInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
}

#pragma mark - IBActions

- (IBAction)signIn:(id)sender {
    
    if (self.emailTextField.text && self.passwordTextField.text &&
        [self.emailTextField.text length] > 0 && [self.passwordTextField.text length] > 0) {
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];

        AppDelegate *appDelegateTemp = [[UIApplication sharedApplication] delegate];
        appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
}

- (IBAction)dismissView:(id)sender {
    
    NSLog(@"Button pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
