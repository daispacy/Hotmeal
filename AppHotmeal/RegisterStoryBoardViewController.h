//
//  RegisterStoryBoardViewController.h
//  AppHotmeal
//
//  Created by admin on 3/20/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterStoryBoardViewController : UIViewController{
    
    IBOutlet UITextField *txtfullname;
    IBOutlet UITextField *txtaddress;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtretypepassword;
    IBOutlet UITextField *txtpassword;
    IBOutlet UITextField *txtphone;
}
@property (strong, nonatomic) IBOutlet UITextField *txtphone;
@property (strong, nonatomic) IBOutlet UITextField *txtpassword;
@property (strong, nonatomic) IBOutlet UITextField *txtretypepassword;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtaddress;
@property (strong, nonatomic) IBOutlet UITextField *txtfullname;


@property(assign,nonatomic)BOOL email;
@property(assign,nonatomic)BOOL retypepassword;
@property(assign,nonatomic)BOOL address;
@property(assign,nonatomic)BOOL phone;
@property(assign,nonatomic)BOOL fullname;


- (IBAction)checkFullName:(id)sender;
- (IBAction)checkEmail:(id)sender;
- (IBAction)checkPassword:(id)sender;
- (IBAction)checkPhone:(id)sender;
- (IBAction)checkAddress:(id)sender;

- (IBAction)registerAction:(id)sender;

@end
