//
//  ProcessCartViewController.m
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "ProcessCartViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "selectCell.h"
#import "LoginPopupViewController.h"
#import "UIViewController+MJPopupViewController.h"
@interface ProcessCartViewController()<LoginPopupViewDelegate>{
    
}
@end

@implementation ProcessCartViewController
@synthesize total;
@synthesize ProductCart;
@synthesize User;
@synthesize txtUserName;
@synthesize txtEmail;
@synthesize txtFullName;
@synthesize username;
@synthesize email;
@synthesize fullname;
@synthesize address;
@synthesize idArea;
@synthesize nameArea;
@synthesize txtNote;
@synthesize _loginPopupViewController;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self._loginPopupViewController=[[LoginPopupViewController alloc] initWithNibName:@"LoginPopupViewController" bundle:nil];
    self._loginPopupViewController.delegate=self;
    [self presentPopupViewController:self._loginPopupViewController animationType:1];
	//display alert login
    [self initBorderTextView];
    //[self alert];
    
}

-(void)alert{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Login"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Register"
                                            otherButtonTitles:@"Login", nil];
    
    [message setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    [message show];
}

 -(void)initBorderTextView{
 [[self.txtNote layer] setBorderColor:[[UIColor blackColor] CGColor]];
 [[self.txtNote layer] setBorderWidth:2.3];
 [[self.txtNote layer] setCornerRadius:15];
 }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /*
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Login"])
    {
        UITextField *username = [alertView textFieldAtIndex:0];
        UITextField *password1 = [alertView textFieldAtIndex:1];
        //[_userManager receiveData:self.user password:self.password];
    }else if([title isEqualToString:@"Register"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Notice" message:@"Coming soon" delegate:self cancelButtonTitle:@"Thoat" otherButtonTitles:nil, nil];
        [alert setAlertViewStyle:UIAlertViewStyleDefault];
        [alert show];
    }
     */
}
-(void)returnUser:(LoginPopupViewController *)controller user:(user *)data{
    self.txtUserName.text=data.name;
    self.txtEmail.text=data.email;
    self.txtFullName.text=data.fullname;
    self.txtAddress.text=data.address;
    NSLog(@"%@",data.address);
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
 
    [_txtAddress release];
    [txtNote release];
    [super dealloc];
}

@end
