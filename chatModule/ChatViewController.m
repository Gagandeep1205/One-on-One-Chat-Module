//
//  ChatViewController.m
//  chatModule
//
//  Created by Gagandeep Kaur on 22/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import "ChatViewController.h"
BOOL Scroll = NO;

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

//- (void) viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if ([_arrHistory count]>0)
//    {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_arrHistory count]-1 inSection:0];
//        [self.tableChat scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//    }
//}

- (IBAction)btnChoosePhoto:(id)sender {
    
    
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

#pragma mark - table view delegates

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_arrHistory count]-1 inSection:0];
//    [self.tableChat scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    return [_arrHistory count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"user_id_1" ]  isEqual: @"1488"] )
    {
        if (Scroll == NO){
        
            [self.tableChat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.arrHistory.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            Scroll = YES;
        }
        if ([[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"image" ] isEqual: @""] || [[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"image" ] isEqual: @"NoImage.jpeg"]){
            
            SendTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendTextCell"];
            cell.labelSendText.text = [[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"message"];
            _strForHeight = cell.labelSendText.text;
            cell.labelSendText.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3];
            cell.labelSendText.textAlignment = NSTextAlignmentRight;
            return cell;
        }
        else {
  
            SendImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SendImageCell"];
            [cell.imgSendImage sd_setImageWithURL:[[_arrHistory objectAtIndex:indexPath.row] valueForKey:@"img_url_100x100"]placeholderImage:nil];
            return cell;
            }
    }
    else  if([[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"user_id_1" ]  isEqual: @"1470"]){
        if(Scroll == NO){
        
            [self.tableChat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.arrHistory.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            Scroll = YES;
        }
        
        if ([[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"image" ] isEqual: @""]|| [[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"image" ] isEqual: @"NoImage.jpeg"]){
            
            RecieveTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecieveTextCell"];
            cell.labelRecieveText.text = [[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"message"];
            cell.labelRecieveText.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
            cell.labelRecieveText.textAlignment = NSTextAlignmentLeft;
            return cell;
        }
        
        else {
            RecieveImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecieveImageCell"];
            [cell.imgRecieveImage sd_setImageWithURL:[[_arrHistory objectAtIndex:indexPath.row] valueForKey:@"image"] placeholderImage:nil];
            
            return cell;
            

        }
    }
    else {
    
        SendTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendTextCell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"image" ] isEqual: @""]|| [[[_arrHistory objectAtIndex:indexPath.row]valueForKey:@"image" ] isEqual: @"NoImage.jpeg"]){
 
            CGSize textSize = [[[_arrHistory objectAtIndex:indexPath.row] valueForKey:@"message"] sizeWithFont:[UIFont systemFontOfSize:40.f] constrainedToSize:CGSizeMake(1000, 1000) lineBreakMode: NSLineBreakByWordWrapping];

            return textSize.height ;
    }
    else {
        
        return 150.f;
    }
    
}

#pragma marl - textField delegates

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    
    return YES;
}

#pragma mark - button action send image

- (IBAction)btnImagePicker:(id)sender {
  //  Scroll = NO;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Choose an option" message:@"Select an Option" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Take Image",@"Choose Image", nil];
    [alert show];
    
}
#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        NSLog(@"Camera not found");
    }else
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:NULL];
        [_tableChat reloadData];

    }
}



#pragma mark - UIImagePicker Controller Delegates

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *image = UIImagePNGRepresentation(chosenImage);
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
    [dicPostMessage setObject:@"" forKey:@"message"];
    [dataModal sendImage : dicPostMessage : image: ^(NSDictionary *response_success) {
        
        NSLog(@"dsbhsfgfhjghsdghjdscvgvcvgvgh");
    } :^(NSError *response_error) {
        
        NSLog(@"%@",response_error);
    }];
    
}
@end