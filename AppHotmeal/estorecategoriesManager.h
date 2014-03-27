//
//  estorecategoriesManager.h
//  AppHotmeal
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "estorecategoriesDelegate.h"
#import "estorecategoriesManagerDelegate.h"
@class estorecategoriesConnect;
@interface estorecategoriesManager : NSObject<estorecategoriesDelegate>
@property(strong,nonatomic)estorecategoriesConnect*ecConnect;
@property(strong,nonatomic)id<estorecategoriesManagerDelegate> delegate;
-(void)receiveDataECate:(NSString*)ida;
@end
