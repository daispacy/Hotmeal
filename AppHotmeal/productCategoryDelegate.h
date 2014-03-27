//
//  productCategoryDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol productCategoryDelegate
-(void)getProductCate:(NSData*)data;
-(void)getProductCateFailed:(NSError*)error;
@end
