//
//  PlaceDeliveryViewController.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderaddress.h"
@protocol PlaceDeliveryViewDelegate;
@interface PlaceDeliveryViewController : UIViewController{
    id<PlaceDeliveryViewDelegate>__weak delegate;
}
@property(weak,nonatomic)id<PlaceDeliveryViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableArea;
@property(strong,nonatomic)NSString*idEstore;
@end
@protocol PlaceDeliveryViewDelegate<NSObject>
@optional
- (NSString*)getIdEstore:(PlaceDeliveryViewController*)controller;
-(void)setArrayOrderAddress:(PlaceDeliveryViewController*)controller orderaddress:(orderaddress*)od;
@end