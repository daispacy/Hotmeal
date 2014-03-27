//
//  productManager.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "productManagerDelegate.h"
#import "productDelegate.h"
@class productConnect;
@interface productManager : NSObject<productDelegate>
@property(strong,nonatomic)productConnect*proConnect;
@property(strong,nonatomic)id<productManagerDelegate> delegate;
-(void)receiveData:(NSString*)idEstore;
@end
