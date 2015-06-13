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

#import "AFNetworking.h"

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
    
    // Register notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bookVenue) name:@"didBookVenue" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Index: %@", indexPath.description);
    
    if (indexPath.row == 2) {
        [self openDateSelectionControllerWithIndex:indexPath.row];
    } else if (indexPath.row == 4) {
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
        dateFormatter.dateStyle = NSDateFormatterFullStyle;
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        NSLog(@"Row: %ld", (long)row);
        
        if (row == 2) {
            NSLog(@"Date start: %@", ((UIDatePicker *)controller.contentView).date);
            self.startLabel.text = dateString;
        } else if (row == 4) {
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
    } else if (row == 3){
        dateSelectionController.title = @"until when?";
    }
    
    dateSelectionController.message = @"This is a test message.\nPlease choose a date and press 'Select' or 'Cancel'.";

    [self presentViewController:dateSelectionController animated:YES completion:nil];
}

#pragma mark - Methods

- (void)customizeViews {
    
    self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    
    self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width / 2;
    self.logoImageView.layer.borderWidth = 2;
    self.logoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UINib *nib = [UINib nibWithNibName:@"OLBookView" bundle:nil];
    UIView *bookView = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    CGRect frame = bookView.frame;
    frame.origin.y = [[UIScreen mainScreen] bounds].size.height - bookView.frame.size.height - 8;
    frame.origin.x = 8;
    frame.size.width = [[UIScreen mainScreen] bounds].size.width - 16;
    [bookView setFrame:frame];
    self.navigationController.delegate = bookView;
    [self.navigationController.view addSubview:bookView];

}

- (void)bookVenue {
    
    NSDictionary *parameters = @{
                                 @"start_at":@"",
                                 @"end_at":@""
                                 };
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"http://192.168.2.1:8000/api/v1/book?token=%@", [defaults valueForKey:@"token"]]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Response: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

@end
