//
//  orderaddressBuilder.h
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderaddressBuilder : NSObject
+(NSArray*)getDataOrderAddress:(NSData*)data error:(NSError**)error;
@end
