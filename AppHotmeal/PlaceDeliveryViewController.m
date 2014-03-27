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
#import "functions.h"
@interface PlaceDeliveryViewController ()<orderaddressManagerDelegate>{
    NSMutableArray*_orderaddress;
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
    [_odManager receiveData:self.idEstore idarea:@""];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    self.idEstore=[self.delegate getIdEstore:self];
    //[_odManager receiveData:self.idEstore idarea:nil];
   
}
-(void)viewWillAppear:(BOOL)animated{
    self.idEstore=[self.delegate getIdEstore:self];
    [_odManager receiveData:self.idEstore idarea:@""];
   
}
-(void)getDataOrderAddress:(NSArray *)data{
    _orderaddress=[[NSMutableArray alloc]init];
    [_orderaddress addObjectsFromArray:data];
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
    [_orderaddress sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    //if(_orderaddress.count<1){
       // [functions alert:@"Quán chỉ giao đến khu vực hiện tại." title:@"Chú ý" buttonTitle:@"OK" controller:self];
       // [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
   // }
    [self.tableArea reloadData];
    
}

-(void)getDataOrderAddressFailed:(NSError *)error{
    [functions alert:@"Lỗi kết nối server." title:@"Lỗi" buttonTitle:@"OK" controller:self];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"nhung noi giao %d",_orderaddress.count);
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
    cell.textLabel.textAlignment=UITextAlignmentRight;
     cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ (%@) %@ VND",object.name,object.times,[functions convertFromNumberToString:object.price]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderaddress*object =_orderaddress[indexPath.row];
    [self.delegate setArrayOrderAddress:self orderaddress:object];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
