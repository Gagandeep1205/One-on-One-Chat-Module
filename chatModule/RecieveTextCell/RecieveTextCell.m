//
//  RecieveTextCell.m
//  chatModule
//
//  Created by Gagandeep Kaur on 24/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import "RecieveTextCell.h"

@implementation RecieveTextCell

- (void)awakeFromNib {
    // Initialization code
    _labelRecieveText.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
