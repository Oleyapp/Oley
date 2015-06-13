//
//  OLSignUpController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLSignUpController.h"

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

- (IBAction)dismissView:(id)sender {
    NSLog(@"Button pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
