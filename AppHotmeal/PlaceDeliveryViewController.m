//
//  PlaceDeliveryViewController.m
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "PlaceDeliveryViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "orderaddress.h"
#import "orderaddressManager.h"
#import "orderaddressConnect.h"
@interface PlaceDeliveryViewController ()<orderaddressManagerDelegate>{
    NSArray*_orderaddress;
    orderaddressManager*_odManager;
}

@end

@implementation PlaceDeliveryViewController
@synthesize idEstore;
@synthesize tableArea;
@synthesize delegate;
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
    self.idEstore=[self.delegate getIdEstore:self];
    _odManager=[[orderaddressManager alloc]init];
    _odManager.odConnect=[[orderaddressConnect alloc]init];
    _odManager.odConnect.delegate=_odManager;
    _odManager.delegate=self;
    //[_odManager receiveData:self.idEstore idarea:nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    self.idEstore=[self.delegate getIdEstore:self];
    //[_odManager receiveData:self.idEstore idarea:nil];
    NSLog(@"%@",self.idEstore);
}
-(void)viewWillAppear:(BOOL)animated{
    self.idEstore=[self.delegate getIdEstore:self];
    [_odManager receiveData:self.idEstore idarea:@""];
    NSLog(@"%@",self.idEstore);
}
-(void)getDataOrderAddress:(NSArray *)data{
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
    [data sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    _orderaddress=data;
    [self.tableArea reloadData];
}
-(void)alert:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thông báo" message: message delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; [alert release];
}
-(void)getDataOrderAddressFailed:(NSError *)error{
    [self alert:@"Lỗi nhận dữ liệu từ server."];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"so luong orderaddress%@",[NSString stringWithFormat:@"%d",_orderaddress.count]);
    return _orderaddress.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    orderaddress*object = _orderaddress[indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell = [[[NSBundle mainBundle] loadNibNamed:@"popupAreaCell" owner:self options:nil] lastObject];
    }
     cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ (%@) %@ VND",object.name,object.times,[self convertToNumber:object.price]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderaddress*object =_orderaddress[indexPath.row];
    [self.delegate setArrayOrderAddress:self orderaddress:object];
}
-(NSString*)convertToNumber:(NSInteger)value{
    NSNumber *someNumber = [NSNumber numberWithDouble:value];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *someString = [nf stringFromNumber:someNumber];
    return someString;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [tableArea release];
    [super dealloc];
}
@end
