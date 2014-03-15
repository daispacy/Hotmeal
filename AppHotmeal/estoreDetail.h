//
//  estoreDetail.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface estoreDetail : NSObject
@property(strong,nonatomic)NSString* image;
@property(strong,nonatomic)NSString* vn_name;
@property(strong,nonatomic)NSString* en_name;
@property(strong,nonatomic)NSString* address;
@property(strong,nonatomic)NSString* vn_address;
@property(strong,nonatomic)NSString* vn_description;
@property(strong,nonatomic)NSDictionary* properties;
@end
