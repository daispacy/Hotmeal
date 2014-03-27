//
//  ShoppingCartViewController.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceDeliveryViewController.h"
#import "ProcessCartViewController.h"
#import "PaymentViewController.h"
#import "orderaddress.h"
#import "payment.h"
@class ShoppingCartViewController;
@protocol ShoppingCartViewContrllerDelegate <NSObject>
-(NSArray*)getOrderAddress:(ShoppingCartViewController*)controller;
-(NSString*)getNameArea:(ShoppingCartViewController*)controller;
-(NSString*)getIdEstore1:(ShoppingCartViewController*)controller;
-(NSMutableArray*)getProduct:(ShoppingCartViewController*)controller;
-(NSInteger)getTotalCart:(ShoppingCartViewController*)controller;
-(NSInteger)getVat:(ShoppingCartViewController*)controller;
@end
@interface ShoppingCartViewController : UIViewController{
    IBOutlet UITableView* cartView;
    NSMutableArray* cartArray;
    id<ShoppingCartViewContrllerDelegate>delegate;
}
//define delegate
@property(strong,nonatomic)id<ShoppingCartViewContrllerDelegate>delegate;

//define UIBOUTLET
@property (strong, nonatomic) IBOutlet UILabel *txtTotalCart;
@property (strong, nonatomic) IBOutlet UIButton *lblNameArea;
@property (strong, nonatomic) IBOutlet UILabel *lblFeeDelivery;
@property (strong, nonatomic) IBOutlet UITableView *cartView;
@property (strong, nonatomic) IBOutlet UIButton *lblTime;
@property (strong, nonatomic) IBOutlet UIButton *lblPaymentMethod;

//define variables
@property(strong,nonatomic)NSMutableArray* cartArray;//danh sach san pham
@property(strong,nonatomic)NSArray* orderAddress;//danh sach dia chi giao hang
@property(assign,nonatomic)NSInteger totalCart;//tong don hang
@property(strong,nonatomic)NSString*idArea;//id area
@property(strong,nonatomic)NSString*idStore;//id store
@property(assign,nonatomic)NSInteger fee_delivery;//phi giao hang
@property(strong,nonatomic)NSString*time_delivery;//thoi gian giao hang
@property(assign,nonatomic)NSInteger vat;

//define view controller
@property(strong,nonatomic)PaymentViewController*_paymentviewcontroller;
@property(strong,nonatomic)PlaceDeliveryViewController*_placedeliveryviewcontroller;
@property(strong,nonatomic)ProcessCartViewController*_processCartviewcontroller;

//define object
@property(strong,nonatomic)orderaddress*objectOrderAddress;
@property(nonatomic,strong)payment*paymentObject;

//action
- (IBAction)showPopupPayment:(id)sender;
- (IBAction)showPopupArea:(id)sender;
- (IBAction)Process:(id)sender;
- (IBAction)showPopupPicker:(id)sender;
@end
