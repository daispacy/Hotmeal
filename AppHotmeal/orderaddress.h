//
//  orderaddress.h
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderaddress : NSObject
@property(strong,nonatomic)NSString*id;
@property(strong,nonatomic)NSString*name;
@property(strong,nonatomic)NSString*sid;
@property(strong,nonatomic)NSString*address;
@property(assign,nonatomic)NSInteger price;
@property(strong,nonatomic)NSString*times;
@property(assign,nonatomic)NSInteger free_delivery;
@property(assign,nonatomic)NSInteger mini_delivery;
@end
