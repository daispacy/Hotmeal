//
//  ShoppingCartViewController.m
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ProcessCartViewController.h"
#import "orderaddress.h"
#import "orderaddressManager.h"
#import "orderaddressConnect.h"
#import "CartCell.h"
#import "cart.h"
#import "UIViewController+MJPopupViewController.h"
#import "TimePickerViewController.h"
#import "PlaceDeliveryViewController.h"
#import "PaymentViewController.h"
#import "payment.h"
#import "staticConfig.h"
#import "functions.h"

@interface ShoppingCartViewController()<orderaddressManagerDelegate,TimePickerViewDelegate,PlaceDeliveryViewDelegate,PaymentViewDelegate>{
    NSArray*product;
    orderaddressManager*_odManager;
    NSArray*_orderaddress;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *dynamicTVHeight;
@end

@implementation ShoppingCartViewController
@synthesize _placedeliveryviewcontroller;
@synthesize cartView;
@synthesize cartArray;
@synthesize delegate;
@synthesize totalCart;
@synthesize txtTotalCart;
@synthesize idArea;
@synthesize idStore;
@synthesize fee_delivery;
@synthesize objectOrderAddress;
@synthesize paymentObject;
@synthesize _paymentviewcontroller;
@synthesize time_delivery;
@synthesize vat;

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
    self.paymentObject=[[payment alloc]init];
    self.objectOrderAddress=[[orderaddress alloc]init];
    self.cartArray=[[NSMutableArray alloc]init];
    self.fee_delivery=0;
    self._placedeliveryviewcontroller = [[PlaceDeliveryViewController alloc] initWithNibName:@"PlaceDeliveryViewController" bundle:nil];
    self._paymentviewcontroller=[[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
    self._paymentviewcontroller.delegate=self;
    self._placedeliveryviewcontroller.delegate=self;
    //[self.cartView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    //get variables from detailviewcontroller
    [self.cartView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    //get variables from detailviewcontroller
    self.totalCart=[self.delegate getTotalCart:self];
    self.cartArray=[self.delegate getProduct:self];
    self.vat=[self.delegate getVat:self];
    NSLog(@"vat cua estore: %d",self.vat);
    self.objectOrderAddress = [self.delegate getOrderAddress:self][0];
    if(self.objectOrderAddress.free_delivery <self.totalCart){
        self.fee_delivery=objectOrderAddress.price;
    }
    self.totalCart +=self.fee_delivery;
    [self.lblNameArea setTitle:[NSString stringWithFormat:@"%@ (%@)",[self.delegate getNameArea:self],self.objectOrderAddress.times] forState:UIControlStateNormal];
    [self.txtTotalCart setText:[NSString stringWithFormat:@"%@ VND",[functions convertFromNumberToString:self.totalCart]]];
    self.lblFeeDelivery.text=[NSString stringWithFormat:@"%@ VND",[functions convertFromNumberToString:self.fee_delivery]];
    
    [self.cartView reloadData];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.cartView reloadData];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        NSUInteger row = [indexPath row];
        NSUInteger count = [self.cartArray count];
        if (row < count) {
            [self.cartArray removeObjectAtIndex:row];
        }
    }
    [self reloadBadgeNumber];
    [self.cartView reloadData];
}
- (void)reloadBadgeNumber {
    if([self.cartArray count]) {
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%i",self.cartArray.count]];
	} else {
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
	}
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [self.cartArray count];
    
    if (row < count) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}


//delegate from popupPlaceDeliveryViewController
-(NSString*)getIdEstore:(PlaceDeliveryViewController *)controller{
    return [self.delegate getIdEstore1:self];
    
}
-(void)setArrayOrderAddress:(PlaceDeliveryViewController *)controller orderaddress:(orderaddress *)od{
    self.objectOrderAddress = od;
    if(self.objectOrderAddress.free_delivery <self.totalCart){
        self.fee_delivery=objectOrderAddress.price;
    }
    self.totalCart=[self.delegate getTotalCart:self];
    self.totalCart +=self.fee_delivery;
    [self.lblNameArea setTitle:[NSString stringWithFormat:@"%@ (%@)",self.objectOrderAddress.name,self.objectOrderAddress.times] forState:UIControlStateNormal];
    self.lblFeeDelivery.text=[NSString stringWithFormat:@"%@ VND",[functions convertFromNumberToString:self.fee_delivery]];
    [self.txtTotalCart setText:[NSString stringWithFormat:@"%@ VND",[functions convertFromNumberToString:self.totalCart]]];
    [self.cartView reloadData];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
//end delegate

//delegate from PaymentViewcontroller
-(NSString*)getIdEstoreFromPaymentViewController:(PaymentViewController *)controller{
    NSLog(@"nhan id store from shopingCart contrller");
    return [self.delegate getIdEstore1:self];
    
}
-(void)setIdAndNamePayment:(PaymentViewController *)controller payment:(payment *)paymentobject{
    self.paymentObject =paymentobject;
    [self.lblPaymentMethod setTitle:[NSString stringWithFormat:@"%@",self.paymentObject.name] forState:UIControlStateNormal];
    [self.cartView reloadData];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
//end delegate


-(void)getDataOrderAddress:(NSArray *)data{
    _orderaddress=data;
}
-(void)getDataOrderAddressFailed:(NSError *)error{
    [functions alert:@"Lỗi dữ liệu từ server" title:@"Error" buttonTitle:@"OK" controller:self];
}

//----Get time from class timepickerviewcontroller
-(void)getTime:(TimePickerViewController *)controller date:(NSDate *)date{
    self.time_delivery=[functions convertDateToString:date];
    [self.lblTime setTitle:[functions convertDateToString:date] forState:UIControlStateNormal];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cartArray count];
}
-(void)viewDidLayoutSubviews
{
    CGFloat height = MAX(self.view.bounds.size.height, self.cartView.contentSize.height);
    self.dynamicTVHeight.constant = height;
    [self.view layoutIfNeeded];
}
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cart *objectCart = [self.cartArray objectAtIndex:indexPath.row];
    [cell.quantity addTarget:self action:@selector(checkPrice:) forControlEvents:UIControlEventEditingChanged];
    cell.nameProduct.text=objectCart.name;
    [cell.price setText:[NSString stringWithFormat:@"%@ VND",[functions convertFromNumberToString:objectCart.total]]];
    cell.quantity.text=[NSString stringWithFormat:@"%d",objectCart.quantity];
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"processCart"]) {
        if(self.time_delivery==nil){
            NSDate*date=[NSDate date];
            self.time_delivery=[functions convertDateToString:date];
        }
        ProcessCartViewController*_processVC=segue.destinationViewController;
        _processVC.idEstore = self.objectOrderAddress.sid;
        _processVC.idArea=self.objectOrderAddress.address;
        _processVC.ProductCart=self.cartArray;
        _processVC._objectOrderAddress=self.objectOrderAddress;
        _processVC.id_delivery=self.objectOrderAddress.id;
        _processVC.form_of_payment=self.paymentObject.id;
        NSArray* foo = [self.time_delivery componentsSeparatedByString: @" ngày "];
        _processVC.delivery_date=[foo objectAtIndex: 1];
        _processVC.delivery_time=[foo objectAtIndex:0];
        _processVC.total = self.totalCart;
        _processVC.vat=[NSString stringWithFormat:@"%d",self.vat];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Process:(id)sender {
    [self performSegueWithIdentifier:@"processCart" sender:self];
}

- (IBAction)showPopupPicker:(id)sender {
    TimePickerViewController *timeViewController = [[TimePickerViewController alloc] initWithNibName:@"TimePickerViewController" bundle:nil];
    timeViewController.delegate=self;
    [self presentPopupViewController:timeViewController animationType:ANIMATE];
}
- (IBAction)showPopupArea:(id)sender {
    [self presentPopupViewController:self._placedeliveryviewcontroller animationType:ANIMATE];
}
- (IBAction)showPopupPayment:(id)sender {
    [self presentPopupViewController:self._paymentviewcontroller animationType:ANIMATE];
}
@end
