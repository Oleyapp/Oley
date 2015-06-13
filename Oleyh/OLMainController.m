//
//  OLMainController.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLMainController.h"
#import "OLVenueController.h"
#import "OLMainCell.h"

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
    
    self.venues = @[@"1", @"2", @"3", @"3", @"3"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
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
    
    cell.nameLabel.text = @"Venue name";
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

@end
