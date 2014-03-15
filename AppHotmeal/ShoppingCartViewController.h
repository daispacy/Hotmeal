//
//  ShoppingCartViewController.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceDeliveryViewController.h"
#import "orderaddress.h"
#import "loginViewController.h"
@class ShoppingCartViewController;
@protocol ShoppingCartViewContrllerDelegate <NSObject>
-(NSArray*)getOrderAddress:(ShoppingCartViewController*)controller;
-(NSString*)getNameArea:(ShoppingCartViewController*)controller;
-(NSString*)getIdEstore1:(ShoppingCartViewController*)controller;
-(NSMutableArray*)getProduct:(ShoppingCartViewController*)controller;
-(NSInteger)getTotalCart:(ShoppingCartViewController*)controller;
@end
@interface ShoppingCartViewController : UIViewController{
    IBOutlet UITableView* cartView;
    NSMutableArray* cartArray;
    id<ShoppingCartViewContrllerDelegate>delegate;
}
- (IBAction)showPopupPicker:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *cartView;
@property (retain, nonatomic) IBOutlet UIButton *btnProcess;
@property(strong,nonatomic)NSMutableArray* cartArray;
@property(strong,nonatomic)NSArray* orderAddress;
@property(assign,nonatomic)NSInteger totalCart;
- (IBAction)Process:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *txtTotalCart;
@property (retain, nonatomic) IBOutlet UIButton *lblNameArea;
@property (retain, nonatomic) IBOutlet UILabel *lblFeeDelivery;
@property(strong,nonatomic)NSString*idArea;
@property(strong,nonatomic)NSString*idStore;
@property(strong,nonatomic)id<ShoppingCartViewContrllerDelegate>delegate;
@property (retain, nonatomic) IBOutlet UIButton *lblTime;
- (IBAction)showPopupArea:(id)sender;
@property(assign,nonatomic)NSInteger fee_delivery;
@property(retain,nonatomic)PlaceDeliveryViewController*_placedeliveryviewcontroller;
@property(strong,nonatomic)orderaddress*object;
@end
