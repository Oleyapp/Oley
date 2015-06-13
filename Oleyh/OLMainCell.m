//
//  OLMainCell.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "OLMainCell.h"

@implementation OLMainCell

- (void)awakeFromNib {
    // Initialization code
    self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width / 2;
    self.logoImageView.layer.borderWidth = 2;
    self.logoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
