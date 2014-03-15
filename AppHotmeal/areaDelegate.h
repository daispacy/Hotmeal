//
//  areaDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol areaDelegate
-(void)getDataArea:(NSData*)data;
-(void)getDataAreaFailed:(NSError*)error;
@end
