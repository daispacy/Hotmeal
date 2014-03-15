//
//  userConnect.h
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol userDelegate;
@interface userConnect : NSObject
@property(strong,nonatomic)id<userDelegate> delegate;
-(void)getUsers:(NSString*)user password:(NSString*)password;

@end
