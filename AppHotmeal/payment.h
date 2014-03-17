//
//  payment.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface payment : NSObject
@property(strong,nonatomic)NSString*id;
@property(strong,nonatomic)NSString*name;
@property(assign,nonatomic)NSInteger fee;
@property(assign,nonatomic)NSInteger position;
@end
