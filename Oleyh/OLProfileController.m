//
//  OLProfileController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLProfileController.h"
#import "UIImageView+Letters.h"
#import "OLOnboardController.h"
#import "AppDelegate.h"

@interface OLProfileController ()

@end

@implementation OLProfileController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    [self.profileImageView setImageWithString:[defaults valueForKey:@"name"] color:[UIColor grayColor] circular:YES];
    self.nameLabel.text = [defaults valueForKey:@"name"];
    
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"path: %ld", (long)indexPath.row);
    
    if (indexPath.row == 2) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dict = [defaults dictionaryRepresentation];
        for (id key in dict) {
            [defaults removeObjectForKey:key];
        }
        [defaults synchronize];
        
        AppDelegate *appDelegateTemp = [[UIApplication sharedApplication] delegate];
        OLOnboardController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
                                   instantiateViewControllerWithIdentifier:@"onboard"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        appDelegateTemp.window.rootViewController = nav;

    }
}

#pragma mark - IBActions

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
