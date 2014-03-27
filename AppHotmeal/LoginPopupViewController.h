//
//  LoginPopupViewController.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "user.h"
@protocol LoginPopupViewDelegate;
@interface LoginPopupViewController : UIViewController{
    id<LoginPopupViewDelegate>__weak delegate;
}
@property(weak,nonatomic)id<LoginPopupViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnRegister:(id)sender;
@end
@protocol LoginPopupViewDelegate<NSObject>
@optional
-(void)returnUser:(LoginPopupViewController*)controller user:(user*)data;
-(void)callRegister:(LoginPopupViewController*)controller;
@end