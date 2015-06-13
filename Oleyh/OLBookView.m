//
//  OLBookView.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/14/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLBookView.h"
#import "OLVenueController.h"

@implementation OLBookView

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[OLVenueController class]]) {
        self.hidden = NO;
    } else {
        self.hidden = YES;        
    }
}

#pragma mark - IBActions

- (IBAction)bookVenue:(id)sender {
    NSLog(@"Button pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didBookVenue" object:nil];
}

@end
