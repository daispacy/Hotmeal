//
//  LoginPopupViewController.m
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "LoginPopupViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "user.h"
#import "userManager.h"
#import "userConnect.h"
@interface LoginPopupViewController ()<userManagerDelegate>{
    NSArray*_user;
    userManager*_userManager;
}

@end

@implementation LoginPopupViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _userManager=[[userManager alloc]init];
    _userManager.userConnect=[[userConnect alloc]init];
    _userManager.userConnect.delegate=_userManager;
    _userManager.delegate=self;
   
}
-(void)getDataUser:(NSArray *)data{
    _user=data;
    user*object=_user[0];
    if([object.error isEqualToString:@"FALSE"]){
        [self.delegate returnUser:self user:object];
    }else{
        [self alert];
    }
}
-(void)alert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thông báo" message: @"Số điện thoại hoặc mật khẩu không đúng!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; [alert release];
}
-(void)getDataUserFailed:(NSError *)error{
    NSLog(@"Loi get user: %@",[error description]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_txtUsername release];
    [_txtPassword release];
    [super dealloc];
}
- (IBAction)btnLogin:(id)sender {
    [_userManager receiveData:self.txtUsername.text password:self.txtPassword.text];
}

- (IBAction)btnRegister:(id)sender {
    //[self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.delegate callRegister:self];
}
@end
