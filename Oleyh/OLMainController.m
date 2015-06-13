//
//  OLMainController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLMainController.h"
#import "OLVenueController.h"
#import "OLProfileController.h"
#import "OLMainCell.h"

#import "AFNetworking.h"

#import "UINavigationController+KeyboardDismiss.h"

@interface OLMainController ()

@property (strong, nonatomic) NSArray *venues;

@end

@implementation OLMainController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Nearby";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    [self getVenueRequest];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationItem.title = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OLMainCell *cell = (OLMainCell *)[tableView dequeueReusableCellWithIdentifier:@"main_cell"];
    
    if (!cell) {
        cell = [[OLMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"main_cell"];
    }
    
    cell.nameLabel.text = @"This is such a long venue name, Bangi";
    cell.descriptionLabel.text = @"Venue description";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OLVenueController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"venue"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Methods

- (void)getVenueRequest {
    
    NSDictionary *parameters = @{};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://192.168.2.1:8000/api/v1/courts" parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"Response: %@", responseObject);
             
             if ([responseObject isKindOfClass:[NSArray class]]) {
                 self.venues = responseObject;
             }
             
             [self.tableView reloadData];
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // Handle errors
         }];
}

#pragma mark - IBActions

- (IBAction)viewProfile:(id)sender {
    
    OLProfileController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"profile"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
