//
//  loginViewController.m
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "loginViewController.h"
#import "ProcessCartViewController.h"
#import "userConnect.h"
#import "userManager.h"
#import "user.h"
@interface loginViewController ()<userManagerDelegate>{
    userManager*_userManager;
    NSArray*_user;
}


@end

@implementation loginViewController
@synthesize username;
@synthesize password;
@synthesize UserArray;
@synthesize ProductCart;
@synthesize total;
@synthesize _error;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.UserArray = [[NSArray alloc]init];
    self._error=TRUE;
    _userManager=[[userManager alloc]init];
    _userManager.userConnect=[[userConnect alloc]init];
    _userManager.userConnect.delegate=_userManager;
    _userManager.delegate=self;
    //[_userManager receiveData:self.username.text password:self.password.text];
}
-(void)getDataUser:(NSArray *)data{
    _user=data;
    user*object=_user[0];
    if([object.error isEqualToString:@"FALSE"]){
        [self performSegueWithIdentifier:@"LoginSuccess" sender:self];
    }else{
        [self alert];
    }
}
-(void)getDataUserFailed:(NSError *)error{
    NSLog(@"Loi get user: %@",[error description]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alert{
UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thông báo" message: @"Số điện thoại hoặc mật khẩu không đúng!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; [alert release];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"LoginSuccess"]) {
        user *object = _user[0];
        ProcessCartViewController *processViewController= segue.destinationViewController;
        processViewController.fullname = object.fullname;
        processViewController.email = object.email;
        processViewController.username=object.name;
        processViewController.address=object.address;
        processViewController.ProductCart = self.ProductCart;
        processViewController.total=self.total;
        
    }
}
- (void)dealloc {
    [user release];
    [password release];
    [super dealloc];
}

- (IBAction)login:(id)sender {
    [_userManager receiveData:self.username.text password:self.password.text];
    //NSLog(self._error?@"TRUE":@"FALSE");
    
    
}
@end
