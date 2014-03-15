//
//  productCategoryConnect.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol productCategoryDelegate;
@interface productCategoryConnect : NSObject
@property(strong,nonatomic)id<productCategoryDelegate> delegate;
-(void)getProductCategories:(NSString*)idEstore;
@end
