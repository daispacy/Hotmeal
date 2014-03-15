//
//  user.h
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface user : NSObject
@property(strong,nonatomic)NSString*id;
@property(strong,nonatomic)NSString*phone;
@property(strong,nonatomic)NSString*address;
@property(strong,nonatomic)NSString*name;
@property(strong,nonatomic)NSString*email;
@property(assign,nonatomic)NSInteger area_id;
@property(strong,nonatomic)NSString*fullname;
@property(strong,nonatomic)NSString* error;
@end
