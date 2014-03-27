//
//  cart.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cart : NSObject
@property(strong,nonatomic)NSString*id;
@property(strong,nonatomic)NSString*name;
@property(assign,nonatomic)NSInteger quantity;
@property(strong,nonatomic)NSString*store_id;
@property(strong,nonatomic)NSString*price;
@property(assign,nonatomic)NSInteger total;
@end
