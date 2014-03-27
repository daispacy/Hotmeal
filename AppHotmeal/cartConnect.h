//
//  cartConnect.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol cartDelegate;
@interface cartConnect : NSObject
@property(strong,nonatomic)id<cartDelegate> delegate;
-(void)processOrder:(NSString *)post;
@end
