//
//  ViewController.m
//  chatModule
//
//  Created by Gagandeep Kaur on 22/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
BOOL userEnabled  = true;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    userEnabled = true;
    [self initialiseData];
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    userEnabled = true;
}
- (void) initialiseData{
    _arrUserNames = [NSMutableArray arrayWithObjects:@"Gagan", @"Kunal",@"Binit",@"Priyanka", @"Aseem",nil];
    _arrUserID = [NSMutableArray arrayWithObjects:@"2",@"3",@"4",@"5",@"6",nil ];
    _arrUserImages = [NSMutableArray arrayWithObjects:@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"4.jpg",nil ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_arrUserNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    cell.imageView.image = [UIImage imageNamed:[_arrUserImages objectAtIndex:indexPath.row]];
    cell.textLabel.text = [_arrUserNames objectAtIndex:indexPath.row];
    
    return cell;
    
//    UsersTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UsersTableViewCell"];
//    cell.imageViewUsers.image = [UIImage imageNamed:[_arrUserImages objectAtIndex:indexPath.row]];
//    cell.labelUserName.text = [_arrUserNames objectAtIndex:indexPath.row];
//    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(userEnabled == true){
    
        userEnabled = false;
    if (indexPath.row == 0) {
        
        DataModal * dataModal= [[DataModal alloc] init];
        [dataModal CallApi:(@"user_id_1=1488&user_id_2=1470") :^(NSDictionary *response_success) {
            
            _arrData = [NSMutableArray new];
            _arrData = [[response_success valueForKey:@"messages"] mutableCopy];
            NSLog(@"%@", _arrData);
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ChatViewController * VC = [storyBoard instantiateViewControllerWithIdentifier:@"ChatViewController"];
               [VC getChatHistory: _arrData];
            [self.navigationController pushViewController:VC animated:YES];

        }:^(NSError *response_error) {
            NSLog(@"Couldn't Load Images");

        }];
    }
}
}

@end
