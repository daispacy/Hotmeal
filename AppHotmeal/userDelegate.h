//
//  userDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol userDelegate <NSObject>
-(void)getDataUser:(NSData*)data;
-(void)getDataUserFailed:(NSError*)error;
@end
