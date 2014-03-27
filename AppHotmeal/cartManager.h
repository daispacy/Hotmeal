//
//  cartManager.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cartDelegate.h"
#import "cartManagerDelegate.h"
@class cartConnect;
@interface cartManager : NSObject<cartDelegate>
@property(strong,nonatomic)cartConnect*crConnect;
@property(strong,nonatomic)id<cartManagerDelegate> delegate;
-(void)processCart:(NSString*)post;
@end
