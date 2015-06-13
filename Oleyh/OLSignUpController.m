//
//  OLSignUpController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLSignUpController.h"
#import "AppDelegate.h"

@interface OLSignUpController ()

@end

@implementation OLSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)signUp:(id)sender {
    
    if (self.nameTextField && self.emailTextField && self.passwordTextField && [self.nameTextField.text length] > 0 && [self.emailTextField.text length] > 0 && [self.passwordTextField.text length] > 0) {
        
        [self.nameTextField resignFirstResponder];
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
