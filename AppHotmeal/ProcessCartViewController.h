//
//  ProcessCartViewController.h
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProcessCartViewController : UIViewController{
}
@property(assign,nonatomic)NSInteger total;
@property(strong,nonatomic)NSArray* ProductCart;
@property (retain, nonatomic) IBOutlet UITextField *txtAddress;
@property(strong,nonatomic)NSArray* User;
@property (retain, nonatomic) IBOutlet UITextField *txtUserName;
@property (retain, nonatomic) IBOutlet UITextField *txtFullName;
@property(strong,nonatomic)NSString*address;
@property(strong,nonatomic)NSString*username;
@property(strong,nonatomic)NSString*email;
@property(strong,nonatomic)NSString*fullname;
@property (retain, nonatomic) IBOutlet UITextField *txtEmail;
@property(strong,nonatomic)NSString*nameArea;
@property (retain, nonatomic) IBOutlet UITextView *txtNote;
@property(strong,nonatomic)NSString*idArea;
@end
