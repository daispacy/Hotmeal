//
//  productBuilder.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface productBuilder : NSObject
+(NSArray*)getDataProduct:(NSData*)data error:(NSError**)error;
@end
