//
//  ProcessCartViewController.h
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginPopupViewController.h"
#import "RegisterViewController.h"
#import "AlertViewController.h"
#import "user.h"
#import "orderaddress.h"

@interface ProcessCartViewController : UIViewController{
    
}
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextView *txtNote;

// tong hoa don
@property(assign,nonatomic)NSInteger total;
//array product
@property(strong,nonatomic)NSArray* ProductCart;
//object user
@property(strong,nonatomic)user* User;
//bien luu thong tin ca nhan
@property(strong,nonatomic)NSString*message;//thong bao cho nguoi dung
@property(strong,nonatomic)NSString*address;//dia chi
@property(strong,nonatomic)NSString*username;//so dien thoai
@property(strong,nonatomic)NSString*email;//email
@property(strong,nonatomic)NSString*fullname;//ten day du
@property(strong,nonatomic)NSString*nameArea;//ten quan
@property(strong,nonatomic)NSString*idArea;//id quan khach hang
@property(strong,nonatomic)NSString*idEstore;//id estore;
@property(strong,nonatomic)NSString*id_delivery;//id address
@property(strong,nonatomic)NSString*form_of_payment;//id phuong thuc thanh toan
@property(strong,nonatomic)NSString*delivery_date;
@property(strong,nonatomic)NSString*delivery_time;
@property(strong,nonatomic)NSString*vat;

//khai bao bien cho cac controller
@property(strong,nonatomic)LoginPopupViewController*_loginPopupViewController;
@property(strong,nonatomic)RegisterViewController*_registerViewController;
@property(strong,nonatomic)AlertViewController*_alertViewCOntroller;

//define object
@property(strong,nonatomic)orderaddress*_objectOrderAddress;



//event action
- (IBAction)process:(id)sender;
@end
