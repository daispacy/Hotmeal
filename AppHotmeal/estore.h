//
//  estore.h
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface estore : NSObject
@property(strong,nonatomic)NSString* id;
@property(strong,nonatomic)NSString* image;
@property(strong,nonatomic)NSString* name;
@property(assign,nonatomic)NSInteger like;
@property(assign,nonatomic)NSInteger status;
@property(strong,nonatomic)NSString* listime;
@property(strong,nonatomic)NSString* min_delivery;
//@property(strong,nonatomic)NSString* domain;
@end
