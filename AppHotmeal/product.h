//
//  product.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface product : NSObject
@property(strong,nonatomic)NSString *id;
@property(strong,nonatomic)NSString* name;
@property(strong,nonatomic)NSString* sale_price;
@property(strong,nonatomic)NSString* price;
@property(strong,nonatomic)NSString* image;
@property(strong,nonatomic)NSDictionary* properties;
@property(strong,nonatomic)NSString* store_id;
@end
