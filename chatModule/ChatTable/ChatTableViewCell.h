//
//  ChatTableViewCell.h
//  chatModule
//
//  Created by Gagandeep Kaur on 22/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelMessage;
@property (weak, nonatomic) IBOutlet UIImageView *imgChat;

@end
