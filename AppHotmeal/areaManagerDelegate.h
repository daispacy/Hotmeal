//
//  areaManagerDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol areaManagerDelegate
-(void)getDataArea:(NSArray*)data;
-(void)getDataAreaFailed:(NSError*)error;
@end
