//
//  areaManager.h
//  AppHotmeal
//
//  Created by admin on 3/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "areaDelegate.h"
#import "areaManagerDelegate.h"
@class areaConnect;
@interface areaManager : NSObject<areaDelegate>
@property(strong,nonatomic)areaConnect*esConnect;
@property(strong,nonatomic)id<areaManagerDelegate> delegate;
-(void)receiveDataArea;
@end
