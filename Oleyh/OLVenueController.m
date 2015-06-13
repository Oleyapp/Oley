//
//  OLVenueController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLVenueController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RMDateSelectionViewController.h"

@interface OLVenueController ()

@end

@implementation OLVenueController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeViews];
    
    self.navigationItem.title = self.name;
    self.tableView.delegate = self;
    
    self.taglineLabel.text = self.tagline;
//    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.backgroundImageUrl] placeholderImage:nil];
//    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:self.logoImageUrl] placeholderImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Index: %@", indexPath.description);
    
    if (indexPath.row == 1) {
        [self openDateSelectionControllerWithIndex:indexPath.row];
    } else if (indexPath.row == 2) {
        [self openDateSelectionControllerWithIndex:indexPath.row];
    }
}

#pragma mark - IBActions

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Methods

- (void)openDateSelectionControllerWithIndex:(NSInteger)row {
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
        
        NSDate *date = ((UIDatePicker *)controller.contentView).date;
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        if (row == 1) {
            NSLog(@"Date start: %@", ((UIDatePicker *)controller.contentView).date);
            self.startLabel.text = dateString;
        } else if (row == 2) {
            self.endLabel.text = dateString;
        }
        
    }];
    
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        NSLog(@"Date selection was canceled");
    }];
    
    //Create date selection view controller
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleDefault selectAction:selectAction andCancelAction:cancelAction];
    
    if (row == 1) {
        dateSelectionController.title = @"When do you want to book it?";
    } else {
        dateSelectionController.title = @"Till when?";
    }
    
    dateSelectionController.message = @"This is a test message.\nPlease choose a date and press 'Select' or 'Cancel'.";

    [self presentViewController:dateSelectionController animated:YES completion:nil];
}

- (void)customizeViews {
    
    self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width / 2;
    self.logoImageView.layer.borderWidth = 2;
    self.logoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
