//
//  userManager.h
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userDelegate.h"
#import "userManagerDelegate.h"
@class userConnect;
@interface userManager : NSObject<userDelegate>
@property(strong,nonatomic)userConnect*userConnect;
@property(strong,nonatomic)id<userManagerDelegate> delegate;
-(void)receiveData:(NSString*)user password:(NSString*)password;
@end
