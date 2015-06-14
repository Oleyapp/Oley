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
#import "CNPPopUpController.h"
#import "AFNetworking.h"

@interface OLVenueController ()

@property (nonatomic, strong) CNPPopupController *popupController;

@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;

@end

@implementation OLVenueController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeViews];
    
    self.navigationItem.title = self.name;
    self.tableView.delegate = self;
    
    self.taglineLabel.text = self.tagline;
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.backgroundImageUrl] placeholderImage:nil];
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:self.logoImageUrl] placeholderImage:nil];
    
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
            self.dateStart = date;
        } else if (row == 4) {
            self.endLabel.text = dateString;
            self.dateEnd = date;
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

- (void)showPopupSuccessWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSString *descriptionString = @"Your booking have been accepted. Be there on time. :)";

    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Avenir-medium" size:18.0], NSParagraphStyleAttributeName : paragraphStyle}];
    UIImage *icon = [UIImage imageNamed:@"IconSuccess"];
    
    NSAttributedString *buttonTitle2 = [[NSAttributedString alloc] initWithString:@"Yes" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Avenir-medium" size:18.0], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem2 = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle2 backgroundColor:[UIColor colorWithRed:0.233 green:0.480 blue:0.858 alpha:1.000]];
    buttonItem2.selectionHandler = ^(CNPPopupButtonItem *item){
        NSLog(@"Block for button: %@", item.buttonTitle.string);
    };
    
    self.popupController = [[CNPPopupController alloc] initWithTitle:nil contents:@[icon, lineOne]
                                                         buttonItems:@[buttonItem2]
                                               destructiveButtonItem:nil];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    
    self.popupController.theme.contentVerticalPadding = 20.0f;
    //    self.popupController.delegate = self;
    self.popupController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupController presentPopupControllerAnimated:YES];
}

- (void)showPopupFailedWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSString *descriptionString = @"Aww shucks, it looks like there is no available spot. Try at another time.";
    //
    //    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"It's A Popup!" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Avenir-medium" size:18.0], NSParagraphStyleAttributeName : paragraphStyle}];
    UIImage *icon = [UIImage imageNamed:@"IconErrors"];
    
    NSAttributedString *buttonTitle2 = [[NSAttributedString alloc] initWithString:@"Okay" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Avenir-medium" size:18.0], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem2 = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle2 backgroundColor:[UIColor colorWithRed:0.233 green:0.480 blue:0.858 alpha:1.000]];
    buttonItem2.selectionHandler = ^(CNPPopupButtonItem *item){
        NSLog(@"Block for button: %@", item.buttonTitle.string);
    };
    
    self.popupController = [[CNPPopupController alloc] initWithTitle:nil contents:@[icon, lineOne]
                                                         buttonItems:@[buttonItem2]
                                               destructiveButtonItem:nil];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    
    self.popupController.theme.contentVerticalPadding = 20.0f;
    //    self.popupController.delegate = self;
    self.popupController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupController presentPopupControllerAnimated:YES];
}


#pragma mark - NSNotifications

- (void)bookVenue {

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *startDate = [dateFormatter stringFromDate:self.dateStart];
    NSString *endDate = [dateFormatter stringFromDate:self.dateEnd];
    
    NSDictionary *parameters = @{
                                 @"court_id": self.venueId,
                                 @"start_at":startDate,
                                 @"end_at":endDate
                                 };
    
    NSLog(@"PArams: %@", parameters);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"http://192.168.2.1:8000/api/player/v1/book?token=%@", [defaults valueForKey:@"token"]]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Response: %@", responseObject);
              
              [self showPopupSuccessWithStyle:CNPPopupStyleCentered];
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              [self showPopupFailedWithStyle:CNPPopupStyleCentered];

          }];
}

@end
