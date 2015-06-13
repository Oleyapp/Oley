//
//  OLSignUpController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLSignUpController.h"
#import "AFNetworking.h"
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
        
        NSDictionary *parameters = @{
                                     @"name":self.nameTextField.text,
                                     @"email":self.emailTextField.text,
                                     @"password":self.passwordTextField.text
                                     };
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"http://192.168.2.1:8000/api/player/v1/register" parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"Response: %@", responseObject);
                  
                  [self.nameTextField resignFirstResponder];
                  [self.emailTextField resignFirstResponder];
                  [self.passwordTextField resignFirstResponder];
                  
                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                  [defaults setObject:[responseObject valueForKey:@"token"] forKey:@"token"];
                  [defaults synchronize];
                  
                  AppDelegate *appDelegateTemp = [[UIApplication sharedApplication] delegate];
                  appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];

              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error.description);
              }];
    }
    
   

}

- (IBAction)dismissView:(id)sender {
    NSLog(@"Button pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
