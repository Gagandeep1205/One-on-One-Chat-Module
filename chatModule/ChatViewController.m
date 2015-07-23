//
//  ChatViewController.m
//  chatModule
//
//  Created by Gagandeep Kaur on 22/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import "ChatViewController.h"
BOOL Scroll = YES;

@interface ChatViewController ()

@end

@implementation ChatViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendButtonUI];
    _sendImageView.hidden = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}
-(void) sendButtonUI{
    _btnSendMessage.layer.cornerRadius = 5.0;
}

#pragma mark - getMessages

-(void) getChatHistory:(NSMutableArray*)dict{

    _arrHistory = [[NSMutableArray alloc]init];
    _arrHistory = dict;
    
    DataModal * dataModal= [[DataModal alloc] init];
    [dataModal CallApi:(@"user_id_1=1488&user_id_2=1470") :^(NSDictionary *response_success) {
        
        
        [_tableChat reloadData];
        _arrHistory = [NSMutableArray new];
        _arrHistory = [[response_success valueForKey:@"messages"] mutableCopy];
        NSLog(@"%@", _arrHistory);
        [self getChatHistory:_arrHistory];
        
        
    }:^(NSError *response_error) {
        NSLog(@"Couldn't Load Images");
        [self getChatHistory:_arrHistory];
        
    }];

}
- (void)viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.tableChat endEditing:true];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_arrHistory count];
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if ([[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"user_id_1" ]  isEqual: @"1488"]) {
        cell.labelMessage.text = [[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"message"];
        _stringForHeight = cell.labelMessage.text;
        cell.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3];
        cell.labelMessage.textAlignment = NSTextAlignmentRight;
        [cell.imgChat sd_setImageWithURL:[[_arrHistory objectAtIndex:indexPath.row] valueForKey:@"image"]placeholderImage:nil];
    }
    else {
        cell.labelMessage.text = [[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"message"];
        cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3];
        cell.labelMessage.textAlignment = NSTextAlignmentLeft;
        cell.imgChat = [[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"image"];
    }
    if (_arrHistory.count >0){
        if(Scroll == YES){
            [self.tableChat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.arrHistory.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            Scroll = NO;
         }
    }
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CGFloat requiredSize = cell.labelMessage.frame.size.height + 20;
    
    return requiredSize;

    
    
//    return [self heightForText:_stringForHeight] + 40 ;
}
-(CGFloat)heightForText:(NSString *)text
{
    NSInteger MAX_HEIGHT = 2000;
    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 320, MAX_HEIGHT)];
    textView.text = text;
    textView.font = [UIFont boldSystemFontOfSize:12];
    [textView sizeToFit];
    return textView.frame.size.height;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _viewTextMsg.transform = CGAffineTransformMakeTranslation(0, -252);
        _tableChat.transform = CGAffineTransformMakeTranslation(0, -252);
        _tableChat.frame = CGRectMake(0, 0, _tableChat.frame.size.width, _tableChat.frame.size.height-252);
    }];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _viewTextMsg.transform = CGAffineTransformMakeTranslation(0, 0);
        _tableChat.transform = CGAffineTransformMakeTranslation(0, 0);
        _tableChat.frame = CGRectMake(0, 0, _tableChat.frame.size.width, _tableChat.frame.size.height);
    }];
    
    return YES;
}


- (IBAction)actionBtnSendMessage:(id)sender {
    
    
    _currentDate = [NSDate new];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
    NSString *strTimeStamp = [dateFormatter stringFromDate: _currentDate];
    _message = _TFMessage.text;
    _TFMessage.text = @"";
    DataModal * dataModal= [[DataModal alloc] init];
    NSMutableDictionary * dicPostMessage = [[NSMutableDictionary alloc]init];
    [dicPostMessage setObject:@"1488" forKey:@"user_id_1"];
    [dicPostMessage setObject:@"1470" forKey:@"user_id_2"];
    [dicPostMessage setObject:strTimeStamp forKey:@"time_stamp"];
    [dicPostMessage setObject:_message forKey:@"message"];
    [dataModal sendMessage:dicPostMessage :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
    
    [self getChatHistory:_arrHistory];
    
}

- (IBAction)btnTakePhoto:(id)sender {
    NSLog(@"Camera not found");
}

- (IBAction)btnChoosePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    
    return YES;
}

- (IBAction)btnImagePicker:(id)sender {
    
    if (_sendImageView.hidden == NO) {
        _sendImageView.hidden = YES;
    }
    else if(_sendImageView.hidden == YES){
        _sendImageView.hidden = NO;
    }
    
}

#pragma mark - UIImagePicker Controller Delegates

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    _sendImageView.hidden = YES;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    DataModal * dataModal= [[DataModal alloc] init];
    _currentDate = [NSDate new];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
    NSString *strTimeStamp = [dateFormatter stringFromDate: _currentDate];
    NSMutableDictionary * dicPostMessage = [[NSMutableDictionary alloc]init];
    [dicPostMessage setObject:@"1488" forKey:@"user_id_1"];
    [dicPostMessage setObject:@"1470" forKey:@"user_id_2"];
    [dicPostMessage setObject:strTimeStamp forKey:@"time_stamp"];
    
    
    
    [dataModal sendImage : dicPostMessage : imageData: ^(NSDictionary *response_success) {
        
        NSLog(@"dsbhsfgfhjghsdghjdscvgvcvgvgh");
    } :^(NSError *response_error) {
        
        NSLog(@"%@",response_error);
    }];

    
}
@end