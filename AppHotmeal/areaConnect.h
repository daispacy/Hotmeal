//
//  areaConnect.h
//  AppHotmeal
//
//  Created by admin on 3/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol areaDelegate;
@interface areaConnect : NSObject
@property(strong,nonatomic)id<areaDelegate> delegate;
-(void)getArea;
@end
