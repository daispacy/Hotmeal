//
//  orderaddressManager.h
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "orderaddressDelegate.h"
#import "orderaddressManagerDelegate.h"
@class orderaddressConnect;
@interface orderaddressManager : NSObject<orderaddressDelegate>
@property(strong,nonatomic)orderaddressConnect*odConnect;
@property(strong,nonatomic)id<orderaddressManagerDelegate> delegate;
-(void)receiveData:(NSString*)idEstore idarea:(NSString*)idArea;
@end