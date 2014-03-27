//
//  cartBuider.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cartBuider : NSObject
+(NSArray*)getDataCart:(NSData*)data error:(NSError**)error;
@end
