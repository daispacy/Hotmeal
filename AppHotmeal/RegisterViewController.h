//
//  RegisterViewController.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertViewController.h"
#import "user.h"
@protocol RegisterViewDelegate;

@interface RegisterViewController : UIViewController{
    id<RegisterViewDelegate>__weak delegate;
}
@property(weak,nonatomic)id<RegisterViewDelegate>delegate;

@property (strong, nonatomic) IBOutlet UITextField *txtpassword;
@property (strong, nonatomic) IBOutlet UITextField *txtrepassword;
@property (strong, nonatomic) IBOutlet UITextField *txtemail;
@property (strong, nonatomic) IBOutlet UITextField *txtaddress;
@property (strong, nonatomic) IBOutlet UITextField *txtphone;
@property (strong, nonatomic) IBOutlet UITextField *txtfullname;


@property(strong,nonatomic)AlertViewController*_alertViewController;


- (IBAction)checkFullName:(id)sender;
- (IBAction)checkEmail:(id)sender;
- (IBAction)checkPassword:(id)sender;
- (IBAction)process:(id)sender;
- (IBAction)checkPhone:(id)sender;
- (IBAction)checkAddress:(id)sender;


@property(assign,nonatomic)BOOL email;
@property(assign,nonatomic)BOOL retypepassword;
@property(assign,nonatomic)BOOL address;
@property(assign,nonatomic)BOOL phone;
@property(assign,nonatomic)BOOL fullname;
@property(strong,nonatomic)NSString*message;

@end


@protocol RegisterViewDelegate<NSObject>
@optional
-(void)returnUserRegister:(RegisterViewController*)controller user:(user*)data;
@end