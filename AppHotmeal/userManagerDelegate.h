//
//  userManagerDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol userManagerDelegate <NSObject>
-(void)getDataUser:(NSArray*)data;
-(void)getDataUserFailed:(NSError*)error;
@end
