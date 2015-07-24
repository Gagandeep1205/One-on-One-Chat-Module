//
//  SendTextCell.m
//  chatModule
//
//  Created by Gagandeep Kaur on 24/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import "SendTextCell.h"

@implementation SendTextCell

- (void)awakeFromNib {
    // Initialization code
    _labelSendText.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
