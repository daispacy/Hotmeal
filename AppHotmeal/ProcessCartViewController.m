//
//  ProcessCartViewController.m
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "ProcessCartViewController.h"
#import "RegisterViewController.h"
#import "statusCart.h"
#import "cartManager.h"
#import "cartConnect.h"
#import <QuartzCore/QuartzCore.h>
#import "selectCell.h"
#import "LoginPopupViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "user.h"
#import "staticConfig.h"
#import "cart.h"
#import "functions.h"
#import "userDAO.h"

@interface ProcessCartViewController()<LoginPopupViewDelegate,RegisterViewDelegate,cartManagerDelegate,AlertViewDelegate>{
    cartManager*_crManager;
    NSArray*_statusCart;
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
@synthesize _registerViewController;
@synthesize _alertViewCOntroller;
@synthesize idEstore;
@synthesize _objectOrderAddress;
@synthesize id_delivery;
@synthesize form_of_payment;
@synthesize delivery_time;
@synthesize delivery_date;
@synthesize vat;


- (void)viewDidLoad
{
    [super viewDidLoad];
    _crManager=[[cartManager alloc]init];
    _crManager.crConnect=[[cartConnect alloc]init];
    _crManager.crConnect.delegate=_crManager;
    _crManager.delegate=self;
    self.User = [[user alloc]init];
    //init all property
    //self.User=[[user alloc]init];
    //self._objectOrderAddress=[[orderaddress alloc]init];
   // self.ProductCart=[[NSArray alloc]init];
    
    //check payment_id
    if(self.form_of_payment==NULL){
        
        self.form_of_payment=@"1";
    }
    
    
	//involke method set delegate from all Controller
    [self initController];
    
    userDAO*_userDao=[[userDAO alloc]init];
    NSLog([_userDao isUser]?@"TRUE":@"FALSE");
    if ([_userDao isUser]) {
        self.User=[[_userDao getUser] lastObject];
        //NSLog(@"length user khi form load: %d",self.User.name.length);
            [self.txtAddress setText:self.User.address];
            [self.txtEmail setText:self.User.email];
            [self.txtFullName setText:self.User.fullname];
            [self.txtUserName setText:self.User.name];
    } else {
        [self presentPopupViewController:self._loginPopupViewController animationType:ANIMATE];
    }

    //display popup login controller
    
    
    //set border for textview
    [self initBorderTextView];
    
    
}


-(void)initController{
    self._registerViewController=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    self._registerViewController.delegate=self;
    self._loginPopupViewController=[[LoginPopupViewController alloc] initWithNibName:@"LoginPopupViewController" bundle:nil];
    self._loginPopupViewController.delegate=self;
    self._alertViewCOntroller=[[AlertViewController alloc] initWithNibName:@"AlertViewController" bundle:nil];
    self._alertViewCOntroller.delegate=self;
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
    self.User=data;
    [self setTextForTextFeild:data];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
-(void)returnUserRegister:(RegisterViewController *)controller user:(user *)data{
    self.User=data;
    [self setTextForTextFeild:data];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
-(void)setTextForTextFeild:(user*)data{
    self.txtUserName.text=data.name;
    self.txtEmail.text=data.email;
    self.txtFullName.text=data.fullname;
    self.txtAddress.text=data.address;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)callRegister:(LoginPopupViewController *)controller{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self presentPopupViewController:self._registerViewController animationType:ANIMATE];
}
-(void)getDataCart:(NSArray *)data{
    _statusCart=data;
    statusCart *object=_statusCart[0];
    NSLog(@"message: %@",object.message);
    if([object.error isEqualToString:@"TRUE"]){
        [functions alert:@"Đặt hàng không thành công" title:@"Lỗi" buttonTitle:@"OK" controller:self];
    }else{
        self.message=@"Cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi. Chúc quý khách ngon miệng.";
        [self presentPopupViewController:self._alertViewCOntroller animationType:ANIMATE];
    }
}
-(NSString*)setAlert:(AlertViewController *)controller{
    return self.message;
}
-(void)getDataCartFailed:(NSError *)error{
    [functions alert:@"Lỗi dữ liệu từ server" title:@"Error" buttonTitle:@"OK" controller:self];
}


- (IBAction)process:(id)sender {
    NSLog(@"username: %@",self.User.name);
    if(self.User.name==NULL){
        [self presentPopupViewController:self._loginPopupViewController animationType:ANIMATE];
    }else{
        [self ProcessToServer];
    }
}
-(void)ProcessToServer{
    
    NSMutableString*stringProductArray=[[NSMutableString alloc]init];
    for (NSInteger i=0; i<self.ProductCart.count; i++) {
        NSString *group = [NSString stringWithFormat:@"%0.10u", arc4random()];
        cart *objectProduct = [[cart alloc]init];
        objectProduct=self.ProductCart[i];
        [stringProductArray appendString:[NSString stringWithFormat:@"&product_list[]=%@|%@|%@",objectProduct.id,[NSString stringWithFormat:@"%d",objectProduct.quantity],group]];
    }
    NSString*post=[NSString stringWithFormat:@"apikey=%@&op=%@&area_id=%@&cell=%@&delivery_time=%@&delivery_date=%@&email=%@&form_of_payment=%@&fullname=%@&id_delivery=%@&address=%@&rnote=%@&sId=%@&totalCost=%d&vat=%@&voucher_code=%@%@",API,OPORDER,self.idArea,User.name,self.delivery_time,self.delivery_date,User.email,self.form_of_payment,self.txtFullName.text,self.id_delivery,self.txtAddress.text,self.txtNote.text,self.idEstore,self.total,@"",@"",stringProductArray];
    NSLog(@"%@",post);
    [_crManager processCart:post];
}
@end
