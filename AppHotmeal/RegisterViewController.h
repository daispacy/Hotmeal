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
    id<RegisterViewDelegate>delegate;
}
- (IBAction)checkEmail:(id)sender;
- (IBAction)checkPassword:(id)sender;
@property(assign,nonatomic)id<RegisterViewDelegate>delegate;
@property (retain, nonatomic) IBOutlet UITextField *txtpassword;
@property (retain, nonatomic) IBOutlet UITextField *txtrepassword;
@property (retain, nonatomic) IBOutlet UITextField *txtemail;
@property (retain, nonatomic) IBOutlet UITextField *txtaddress;
- (IBAction)process:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *txtphone;
@property (retain, nonatomic) IBOutlet UITextField *txtfullname;
@property(strong,nonatomic)AlertViewController*_alertViewController;
- (IBAction)checkAddress:(id)sender;
@property(assign,nonatomic)NSInteger control;
- (IBAction)checkPhone:(id)sender;
@property(strong,nonatomic)NSString*message;
@end
@protocol RegisterViewDelegate<NSObject>
@optional
-(void)returnUserRegister:(RegisterViewController*)controller user:(user*)data;
@end