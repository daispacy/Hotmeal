//
//  ShoppingCartViewController.m
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "loginViewController.h"
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
@synthesize object;
@synthesize paymentObject;
@synthesize _paymentviewcontroller;
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
    self.object=[[orderaddress alloc]init];
    self.cartArray=[[NSMutableArray alloc]init];
    self.fee_delivery=0;
    self._placedeliveryviewcontroller = [[PlaceDeliveryViewController alloc] initWithNibName:@"PlaceDeliveryViewController" bundle:nil];
    self._paymentviewcontroller=[[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
    self._paymentviewcontroller.delegate=self;
    self._placedeliveryviewcontroller.delegate=self;
    NSLog(@"did load");
}
-(void)viewDidAppear:(BOOL)animated{
    //get variables from detailviewcontroller
    
    [self.cartView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    //get variables from detailviewcontroller
    self.totalCart=[self.delegate getTotalCart:self];
    self.cartArray=[self.delegate getProduct:self];
    self.object = [self.delegate getOrderAddress:self][0];
    if(self.object.free_delivery <self.totalCart){
        self.fee_delivery=object.price;
    }
    self.totalCart +=self.fee_delivery;
    [self.lblNameArea setTitle:[NSString stringWithFormat:@"%@ (%@)",[self.delegate getNameArea:self],self.object.times] forState:UIControlStateNormal];
    [self.txtTotalCart setText:[NSString stringWithFormat:@"%@ VND",[self convertToNumber:self.totalCart]]];
    self.lblFeeDelivery.text=[NSString stringWithFormat:@"%@ VND",[self convertToNumber:self.fee_delivery]];
    NSLog(@"will appear");
    [self.cartView reloadData];
}

//delegate from popupPlaceDeliveryViewController
-(NSString*)getIdEstore:(PlaceDeliveryViewController *)controller{
    NSLog(@"nhan id store from shopingCart contrller");
    return [self.delegate getIdEstore1:self];
    
}
-(void)setArrayOrderAddress:(PlaceDeliveryViewController *)controller orderaddress:(orderaddress *)od{
    self.object = od;
    if(self.object.free_delivery <self.totalCart){
        self.fee_delivery=object.price;
    }
    self.totalCart=[self.delegate getTotalCart:self];
    self.totalCart +=self.fee_delivery;
    [self.lblNameArea setTitle:[NSString stringWithFormat:@"%@ (%@)",self.object.name,self.object.times] forState:UIControlStateNormal];
    self.lblFeeDelivery.text=[NSString stringWithFormat:@"%@ VND",[self convertToNumber:self.fee_delivery]];
    [self.txtTotalCart setText:[NSString stringWithFormat:@"%@ VND",[self convertToNumber:self.totalCart]]];
    NSLog(@"chay vao roi ma %@",od.name);
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


//---convert from interger to string with format
-(NSString*)convertToNumber:(NSInteger)value{
    NSNumber *someNumber = [NSNumber numberWithDouble:value];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *someString = [nf stringFromNumber:someNumber];
    return someString;
}
-(void)getDataOrderAddress:(NSArray *)data{
    _orderaddress=data;
}
-(void)getDataOrderAddressFailed:(NSError *)error{
    NSLog(@"Loi orderaddress: %@",[error description]);
}

//----Get time from class timepickerviewcontroller
-(void)getTime:(TimePickerViewController *)controller date:(NSDate *)date{
    
    [self.lblTime setTitle:[self convertDateToString:date] forState:UIControlStateNormal];
}

-(NSString*)convertDateToString:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH:mm 'ngày' yyyy-MM-dd"];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    NSLog(@"formattedDateString: %@", formattedDateString);
    return formattedDateString;
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
    cell.nameProduct.text=object.name;
    [cell.price setText:[NSString stringWithFormat:@"%@ VND",[self convertToNumber:objectCart.total]]];
    cell.quantity.text=[NSString stringWithFormat:@"%d",objectCart.quantity];
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"processCart"]) {
        loginViewController *loginViewController= segue.destinationViewController;
        loginViewController.ProductCart = self.cartArray;
        loginViewController.total = self.totalCart;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_btnProcess release];
    [txtTotalCart release];
    [_lblNameArea release];
    [_lblFeeDelivery release];
    [_lblTime release];
    [_lblPaymentMethod release];
    [_btnThanhToan release];
    [super dealloc];
}

- (IBAction)Process:(id)sender {
}

- (IBAction)showPopupPicker:(id)sender {
    TimePickerViewController *timeViewController = [[TimePickerViewController alloc] initWithNibName:@"TimePickerViewController" bundle:nil];
    timeViewController.delegate=self;
    [self presentPopupViewController:timeViewController animationType:1];
}
- (IBAction)showPopupArea:(id)sender {
    [self presentPopupViewController:self._placedeliveryviewcontroller animationType:1];
}
- (IBAction)showPopupPayment:(id)sender {
    [self presentPopupViewController:self._paymentviewcontroller animationType:1];
}

- (IBAction)thanhtoan:(id)sender {
    [self performSegueWithIdentifier:@"thanhtoan" sender:self];
}
@end
