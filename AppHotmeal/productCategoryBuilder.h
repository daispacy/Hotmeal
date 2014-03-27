//
//  productCategoryBuilder.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface productCategoryBuilder : NSObject
+(NSArray*)getDataProductCate:(NSData*)data error:(NSError**)error;
@end
