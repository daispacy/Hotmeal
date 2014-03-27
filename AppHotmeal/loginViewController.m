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
#import "userDAO.h"
#import "location.h"
#import "staticConfig.h"
#import "HUD.h"
#import "functions.h"

@interface loginViewController ()<userManagerDelegate>{
    userManager*_userManager;
    NSArray*_user;
    location*_location;
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
    _location=[[location alloc]init];
    [_location initLocation];
    
        //[_userManager receiveData:self.username.text password:self.password.text];
}
-(void)getDataUser:(NSArray *)data{
    _user=data;
    
        //[HUD showUIBlockingIndicatorWithText:@"Loading..."];
    user*object=_user[0];
    if([object.error isEqualToString:@"FALSE"]){
        
        [HUD showUIBlockingIndicatorWithText:@"Loading..." withTimeout:5];
        dispatch_async(kBgQueue, ^{

        userDAO*_userDao=[[userDAO alloc]init];
        [_userDao DeleteUser:NULL];
        [_userDao AddUser:object];
       //object=[[_userDao getUser] lastObject];
        NSLog(@"%@",[_userDao getUser]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUD hideUIBlockingIndicator];
                [self performSegueWithIdentifier:@"choseArea" sender:self];
            });
        });

    }else{
        [self alert];
    }
        }
-(void)getDataUserFailed:(NSError *)error{
    [functions alert:@"Lỗi dữ liệu từ server" title:@"Error" buttonTitle:@"OK" controller:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alert{
UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thông báo" message: @"Số điện thoại hoặc mật khẩu không đúng!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; 
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"LoginSuccess"]) {
        
        
    }
}

- (IBAction)login:(id)sender {

    [_userManager receiveData:self.username.text password:self.password.text];

    
}

- (IBAction)changToViewRegister:(id)sender {
    [self performSegueWithIdentifier:@"registerView" sender:self];
}
@end
