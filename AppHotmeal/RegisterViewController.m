//
//  RegisterViewController.m
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "RegisterViewController.h"
#import "AlertViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "user.h"
#import "userManager.h"
#import "userConnect.h"
#import "staticConfig.h"
#import "functions.h"

@interface RegisterViewController ()<userManagerDelegate,AlertViewDelegate>{
    NSArray*_user;
    userManager*_userManager;
}

@end

@implementation RegisterViewController
@synthesize delegate;
@synthesize txtaddress;
@synthesize txtemail;
@synthesize txtpassword;
@synthesize txtrepassword;
@synthesize txtphone;
@synthesize _alertViewController;
@synthesize message;
@synthesize control;
@synthesize txtfullname;

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
    [self.txtfullname becomeFirstResponder];
}
-(void)getDataUser:(NSArray *)data{
    _user=data;
    user*object=_user[0];
    if([object.error isEqualToString:@"FALSE"]){
        NSLog(@"call delegate to process cart");
        [self.delegate returnUserRegister:self user:object];
    }else{
        [functions alert:object.message title:@"Chú ý" buttonTitle:@"OK" controller:self];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //self._alertViewController=[[AlertViewController alloc] initWithNibName:@"AlertViewController" bundle:nil];
    //self._alertViewController.delegate=self;
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
    [txtphone release];
    [txtpassword release];
    [txtrepassword release];
    [txtemail release];
    [txtaddress release];
    [txtfullname release];
    [super dealloc];
}
- (IBAction)process:(id)sender {
    NSString*post=[NSString stringWithFormat:@"apikey=%@&op=%@&fullname=%@&phone=%@&password=%@&email=%@&address=%@",API,OPREGISTER,self.txtfullname.text,self.txtphone.text,self.txtpassword.text,self.txtemail.text,self.txtaddress.text];
    [_userManager registerUser:post];
}

- (IBAction)checkEmail:(id)sender {
    if (![functions validateEmail:self.txtemail.text])
    {
        NSLog(@"email not in proper format");
        self.control=2;
        [functions alert:@"Email invalid" title:@"Chú ý" buttonTitle:@"OK" controller:self];
    }
}

- (IBAction)checkPassword:(id)sender {
    NSLog(@"%@",[NSString stringWithFormat:@"%@-%@",self.txtpassword.text,self.txtrepassword.text]);
    if(![functions validateRetypePassword:self.txtpassword.text retypepassword:self.txtrepassword.text]){
        NSLog(@"password not match");
        self.message=@"Mật khẩu không trùng khớp";
        self.control=1;
        [functions alert:self.message title:@"Chú ý" buttonTitle:@"OK" controller:self];
        //[self presentPopupViewController:self._alertViewController animationType:ANIMATE];
    }
    
}
-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
            NSLog(@"click vao day roi");
        if (self.control==1) {
            [self.txtrepassword becomeFirstResponder];
        } else if(self.control==2) {
            [self.txtemail becomeFirstResponder];
        } else if (self.control==3){
            [self.txtphone becomeFirstResponder];
        }else if (self.control==4){
            [self.txtaddress becomeFirstResponder];
        }
    
    }

}
-(NSString*)setAlert:(AlertViewController *)controller{
    return self.message;
}

- (IBAction)checkPhone:(id)sender {
    /*
    if([functions validateNumber:self.txtphone.text]==FALSE){
        [functions alert:@"Số điện thoại không hợp lệ" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        self.control=3;
        [self.txtphone becomeFirstResponder];
    }
     */
}
- (IBAction)checkAddress:(id)sender {
    if(![functions validateInput:self.txtaddress length:0]){
        [functions alert:@"Vui lòng cung cấp địa chỉ" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        self.control=4;
    }
}

@end
