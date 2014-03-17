//
//  PaymentViewController.m
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "PaymentViewController.h"
#import "payment.h"
#import "paymentManager.h"
#import "paymentConnect.h"
#import "UIViewController+MJPopupViewController.h"
#import "functions.h"

@interface PaymentViewController ()<paymentManagerDelegate>{
    NSArray*_payment;
    paymentManager*_paymentManager;
}
@end

@implementation PaymentViewController
@synthesize delegate;
@synthesize tblPayment;
@synthesize idEstore;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.idEstore=[self.delegate getIdEstoreFromPaymentViewController:self];
    _paymentManager=[[paymentManager alloc]init];
    _paymentManager.paymentConnect=[[paymentConnect alloc]init];
    _paymentManager.paymentConnect.delegate=_paymentManager;
    _paymentManager.delegate=self;
    [_paymentManager receiveData:self.idEstore];
}
-(void)viewDidAppear:(BOOL)animated{
    self.idEstore=[self.delegate getIdEstoreFromPaymentViewController:self];
    //[_odManager receiveData:self.idEstore idarea:nil];
    NSLog(@"%@",self.idEstore);
}
-(void)viewWillAppear:(BOOL)animated{
    self.idEstore=[self.delegate getIdEstoreFromPaymentViewController:self];
    [_paymentManager receiveData:self.idEstore];
    NSLog(@"%@",self.idEstore);
}
-(void)getDataPayment:(NSArray *)data{
    
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"position" ascending:YES];
    [data sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    _payment=data;
    if(_payment.count<1){
        [functions alert:@"Quán chỉ chấp nhận thanh toán trực tiếp" title:@"Chú ý" buttonTitle:@"OK" controller:self];
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    }
    [self.tblPayment reloadData];
    
}

-(void)getDataPaymentFailed:(NSError *)error{
    [functions alert:@"Connect to server Failed." title:@"" buttonTitle:@"OK" controller:self];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _payment.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    payment*object = _payment[indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell = [[[NSBundle mainBundle] loadNibNamed:@"popupAreaCell" owner:self options:nil] lastObject];
    }
    cell.textLabel.textAlignment=UITextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",object.name]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    payment*object =_payment[indexPath.row];
    [self.delegate setIdAndNamePayment:self payment:object];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [tblPayment release];
    [super dealloc];
}
@end
