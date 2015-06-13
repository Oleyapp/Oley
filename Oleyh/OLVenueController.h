//
//  OLVenueController.h
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLVenueController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *backgroundImageUrl;
@property (strong, nonatomic) NSString *logoImageUrl;
@property (strong, nonatomic) NSString *tagline;
@property (strong, nonatomic) NSNumber *venueId;

@end
