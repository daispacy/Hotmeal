//
//  paymentBuilder.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paymentBuilder : NSObject
+(NSArray*)getDataPayment:(NSData*)data error:(NSError**)error;
@end
