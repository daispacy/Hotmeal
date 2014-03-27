//
//  loginViewController.h
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface loginViewController : UIViewController{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
}
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property(assign,nonatomic)NSInteger total;
@property(strong,nonatomic)NSArray* ProductCart;
@property(strong,nonatomic)NSArray* UserArray;
@property(assign,nonatomic)BOOL _error;
- (IBAction)login:(id)sender;
- (IBAction)changToViewRegister:(id)sender;

@end
