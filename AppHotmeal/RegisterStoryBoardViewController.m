//
//  RegisterStoryBoardViewController.m
//  AppHotmeal
//
//  Created by admin on 3/20/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "RegisterStoryBoardViewController.h"
#import "user.h"
#import "userManager.h"
#import "userConnect.h"
#import "staticConfig.h"
#import "functions.h"
#import "userDAO.h"
#import "HUD.h"

@interface RegisterStoryBoardViewController()<userManagerDelegate>{
    NSArray*_user;
    userManager*_userManager;
}

@end

@implementation RegisterStoryBoardViewController
@synthesize txtretypepassword,txtphone,txtpassword,txtEmail,txtaddress,txtfullname;
@synthesize fullname,email,address,phone,retypepassword;

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
	// Do any additional setup after loading the view.
}
-(void)getDataUser:(NSArray *)data{
    _user=data;
    user*object=_user[0];
    if([object.error isEqualToString:@"FALSE"]){
        
        userDAO*_userDao=[[userDAO alloc]init];
        BOOL delete=[_userDao DeleteUser:NULL];
        if(delete==FALSE){
            [functions alert:@"Có lỗi trong khi xoá user" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        }else{
            [HUD showUIBlockingIndicatorWithText:@"Loading..." withTimeout:5];
            dispatch_async(kBgQueue, ^{
                BOOL create=[_userDao AddUser:object];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(create==TRUE){
                    [self performSegueWithIdentifier:@"viewArea" sender:self];
                }else{
                    [functions alert:@"Có lỗi trong khi lưu user" title:@"Chú ý" buttonTitle:@"OK" controller:self];
                }
            });
        });
        }
    }else{
        [functions alert:object.message title:@"Chú ý" buttonTitle:@"OK" controller:self];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"viewArea"]) {
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //self._alertViewController=[[AlertViewController alloc] initWithNibName:@"AlertViewController" bundle:nil];
    //self._alertViewController.delegate=self;
}
-(void)getDataUserFailed:(NSError *)error{
   [functions alert:@"Lỗi dữ liệu từ server" title:@"Error" buttonTitle:@"OK" controller:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)isValid{
    if([functions validateInput:self.txtaddress length:1]&&[functions validateInput:self.txtfullname length:1]&&[functions validateInput:self.txtpassword length:1]&&[functions validateInput:self.txtEmail length:1]&&[functions validateInput:self.txtphone length:1])return TRUE;
    return FALSE;
}
- (IBAction)registerAction:(id)sender {
    if(self.fullname && self.retypepassword && self.address && self.email && self.phone && [self isValid]){
    NSString*post=[NSString stringWithFormat:@"apikey=%@&op=%@&fullname=%@&phone=%@&password=%@&email=%@&address=%@",API,OPREGISTER,self.txtfullname.text,self.txtphone.text,self.txtpassword.text,self.txtEmail.text,self.txtaddress.text];
         [_userManager registerUser:post];
    }else{
        [functions alert:@"Thông tin cá nhân không hợp lệ hoặc để vẫn để trống " title:@"Chú ý" buttonTitle:@"OK" controller:self];
    }
}

- (IBAction)checkFullName:(id)sender{
    if(![functions validateInput:self.txtfullname length:0]){
        [functions alert:@"Vui lòng cung cấp  họ tên" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        self.fullname=FALSE;
    }else{
        self.fullname=TRUE;
    }
}
- (IBAction)checkEmail:(id)sender{
    if (![functions validateEmail:self.txtEmail.text])
    {
        self.txtEmail.textColor=[UIColor redColor];
        //NSLog(@"email not in proper format");
        self.email=FALSE;
        //[functions alert:@"Email invalid" title:@"Chú ý" buttonTitle:@"OK" controller:self];
    }else{
        self.email=TRUE;
        self.txtEmail.textColor=[UIColor darkTextColor];
    }
}
- (IBAction)checkPassword:(id)sender{
    if(![functions validateRetypePassword:self.txtpassword.text retypepassword:self.txtretypepassword.text]){
        txtretypepassword.textColor=[UIColor redColor];
        // NSLog(@"password not match");
        
        self.retypepassword=FALSE;
        //[functions alert:self.message title:@"Chú ý" buttonTitle:@"OK" controller:self];
        //[self presentPopupViewController:self._alertViewController animationType:ANIMATE];
    }else{
        self.retypepassword=TRUE;
        txtretypepassword.textColor=[UIColor darkTextColor];
    }
}
- (IBAction)checkPhone:(id)sender{
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
- (IBAction)checkAddress:(id)sender{
    if(![functions validateInput:self.txtaddress length:0]){
        [functions alert:@"Vui lòng cung cấp địa chỉ" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        self.address=FALSE;
    }else{
        self.address=TRUE;
    }
}
-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        NSLog(@"click vao day roi");
        if (!self.retypepassword) {
            [self.txtretypepassword becomeFirstResponder];
        } else if(!self.email) {
            [self.txtEmail becomeFirstResponder];
        } else if (!self.phone){
            [self.txtphone becomeFirstResponder];
        }else if (!self.address){
            [self.txtaddress becomeFirstResponder];
        }
        
    }
    
}
@end
