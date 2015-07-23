//
//  ChatViewController.h
//  chatModule
//
//  Created by Gagandeep Kaur on 22/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "DataModal.h"
#import "ChatTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ChatViewController : UIViewController <UITableViewDelegate , UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate>

-(void) getChatHistory:(NSMutableArray*)dict;

@property (weak, nonatomic) IBOutlet UITableView *tableChat;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMessage;
@property (weak, nonatomic) IBOutlet UIButton *Takephoto;
@property (weak, nonatomic) IBOutlet UIButton *choosePhoto;
@property (weak, nonatomic) IBOutlet UIView *sendImageView;
@property (strong,nonatomic) NSMutableArray *arrHistory;
@property (weak, nonatomic) IBOutlet UIView *viewTextMsg;
@property (weak, nonatomic) IBOutlet UITextField *TFMessage;
@property NSDate * currentDate;
@property NSString * message;
@property (strong,nonatomic) NSString *stringForHeight;

- (IBAction)btnImagePicker:(id)sender;
- (IBAction)actionBtnSendMessage:(id)sender;
- (IBAction)btnTakePhoto:(id)sender;
- (IBAction)btnChoosePhoto:(id)sender;
@end

