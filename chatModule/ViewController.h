//
//  ViewController.h
//  chatModule
//
//  Created by Gagandeep Kaur on 22/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsersTableViewCell.h"
#import "ChatTableViewCell.h"
#import "DataModal.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(strong,nonatomic) NSMutableArray * arrUserNames;
@property (strong, nonatomic) NSMutableArray * arrUserID;
@property (strong,nonatomic) NSMutableArray * arrUserImages;
@property (weak, nonatomic) IBOutlet UITableView *tableViewUsers;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewUser;
@property (strong, nonatomic) NSMutableArray * arrData;
@end

