//
//  OLOnboardController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLOnboardController.h"
#import "CBZVectorSplashView.h"

@interface OLOnboardController ()

@end

@implementation OLOnboardController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *splashImage = [UIImage imageNamed:@"LogoOutline"];
    UIColor *splashColor = [UIColor colorWithRed:0.233 green:0.480 blue:0.858 alpha:1.000];
    CBZSplashView *splashView = [CBZSplashView splashViewWithIcon:splashImage backgroundColor:splashColor];
    
    [self.view addSubview:splashView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [splashView startAnimation];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
