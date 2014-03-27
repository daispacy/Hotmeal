//
//  productCategoryManager.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "productCategoryManagerDelegate.h"
#import "productCategoryDelegate.h"
@class productCategoryConnect;
@interface productCategoryManager : NSObject<productCategoryDelegate>
@property(strong,nonatomic)productCategoryConnect*proCateConnect;
@property(strong,nonatomic)id<productCategoryManagerDelegate> delegate;
-(void)receiveData:(NSString*)idEstore;
@end
