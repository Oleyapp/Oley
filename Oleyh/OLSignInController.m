//
//  OLSignInController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLSignInController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

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
        NSDictionary *parameters = @{
                                     @"email":self.emailTextField.text,
                                     @"password":self.passwordTextField.text
                                     };
        
        [SVProgressHUD show];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"http://192.168.2.1:8000/api/player/v1/login" parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"Response: %@", responseObject);
                  [SVProgressHUD dismiss];
                  
                  [self.emailTextField resignFirstResponder];
                  [self.passwordTextField resignFirstResponder];
                  
                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                  [defaults setObject:[responseObject valueForKey:@"token"] forKey:@"token"];
                  [defaults synchronize];
                  
                  AppDelegate *appDelegateTemp = [[UIApplication sharedApplication] delegate];
                  appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
                
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error.description);
                  [SVProgressHUD dismiss];
                  [[[UIAlertView alloc] initWithTitle:@"Aww shucks, an error occured."
                                              message:@"There seems's to be an error with the application."
                                             delegate:self
                                    cancelButtonTitle:@"OK"
                                    otherButtonTitles:nil] show];
              }];
    }
}

- (IBAction)dismissView:(id)sender {
    
    NSLog(@"Button pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
