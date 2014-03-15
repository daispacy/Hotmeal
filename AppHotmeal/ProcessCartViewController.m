//
//  ProcessCartViewController.m
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "ProcessCartViewController.h"
#import "areaListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "selectCell.h"
@interface ProcessCartViewController()
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"user name: %@",self.username);
    self.txtUserName.text=self.username;
    self.txtFullName.text=self.fullname;
    self.txtEmail.text=self.email;
    self.txtAddress.text=self.address;
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"idAreaProcess"]) {
        areaListViewController *areaViewController= segue.destinationViewController;
        areaViewController.idSeque = @"idAreaProcess";
    }
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
