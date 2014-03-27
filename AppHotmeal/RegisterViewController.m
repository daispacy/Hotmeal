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
@synthesize fullname,email,address,phone,retypepassword;
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

-(BOOL)isValid{
    if([functions validateInput:self.txtaddress length:1]&&[functions validateInput:self.txtfullname length:1]&&[functions validateInput:self.txtpassword length:1]&&[functions validateInput:self.txtemail length:1]&&[functions validateInput:self.txtphone length:1])return TRUE;
    return FALSE;
}

- (IBAction)process:(id)sender {
    if(self.fullname && self.retypepassword && self.address && self.email && self.phone && [self isValid]){
        NSString*post=[NSString stringWithFormat:@"apikey=%@&op=%@&fullname=%@&phone=%@&password=%@&email=%@&address=%@",API,OPREGISTER,self.txtfullname.text,self.txtphone.text,self.txtpassword.text,self.txtemail.text,self.txtaddress.text];
        [_userManager registerUser:post];
    }else{
        [functions alert:@"Thông tin cá nhân không hợp lệ hoặc vẫn để trống" title:@"Chú ý" buttonTitle:@"OK" controller:self];
    }
}



- (IBAction)checkFullName:(id)sender {
    if(![functions validateInput:self.txtfullname length:0]){
        [functions alert:@"Vui lòng cung cấp  họ tên" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        self.fullname=FALSE;
    }else{
        self.fullname=TRUE;
    }
}

- (IBAction)checkEmail:(id)sender {
    if (![functions validateEmail:self.txtemail.text])
    {
        self.txtemail.textColor=[UIColor redColor];
        //NSLog(@"email not in proper format");
        self.email=FALSE;
        //[functions alert:@"Email invalid" title:@"Chú ý" buttonTitle:@"OK" controller:self];
    }else{
        self.email=TRUE;
        self.txtemail.textColor=[UIColor darkTextColor];
    }
}

- (IBAction)checkPassword:(id)sender {
    //NSLog(@"%@",[NSString stringWithFormat:@"%@-%@",self.txtpassword.text,self.txtrepassword.text]);
    if(![functions validateRetypePassword:self.txtpassword.text retypepassword:self.txtrepassword.text]){
        txtrepassword.textColor=[UIColor redColor];
       // NSLog(@"password not match");
        self.message=@"Mật khẩu không trùng khớp";
        self.retypepassword=FALSE;
        //[functions alert:self.message title:@"Chú ý" buttonTitle:@"OK" controller:self];
        //[self presentPopupViewController:self._alertViewController animationType:ANIMATE];
    }else{
        self.retypepassword=TRUE;
        txtrepassword.textColor=[UIColor darkTextColor];
    }
    
}
-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
            NSLog(@"click vao day roi");
        if (!self.retypepassword) {
            [self.txtrepassword becomeFirstResponder];
        } else if(!self.email) {
            [self.txtemail becomeFirstResponder];
        } else if (!self.phone){
            [self.txtphone becomeFirstResponder];
        }else if (!self.address){
            [self.txtaddress becomeFirstResponder];
        }
    
    }

}
-(NSString*)setAlert:(AlertViewController *)controller{
    return self.message;
}

- (IBAction)checkPhone:(id)sender {
    
    if([functions validateNumber:self.txtphone.text]==FALSE){
        //[functions alert:@"Số điện thoại không hợp lệ" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        self.txtphone.textColor=[UIColor redColor];
        self.phone=FALSE;
        //[self.txtphone becomeFirstResponder];
    }else{
        self.phone=TRUE;
        self.txtphone.textColor=[UIColor darkTextColor];
    }
     
}
- (IBAction)checkAddress:(id)sender {
    if(![functions validateInput:self.txtaddress length:0]){
        [functions alert:@"Vui lòng cung cấp địa chỉ" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        self.address=FALSE;
    }else{
        self.address=TRUE;
    }
}

@end
