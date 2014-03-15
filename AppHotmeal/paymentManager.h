//
//  paymentManager.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "paymentDelegate.h"
#import "paymentManagerDelegate.h"
@class paymentConnect;
@interface paymentManager : NSObject<paymentDelegate>
@property(strong,nonatomic)paymentConnect*paymentConnect;
@property(strong,nonatomic)id<paymentManagerDelegate> delegate;
-(void)receiveData:(NSString*)idEstore;
@end
