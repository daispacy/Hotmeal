//
//  estoreManager.h
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "estoreManagerDelegate.h"
#import "estoreDelegate.h"
@class estoreConnect;
@interface estoreManager : NSObject<estoreDelegate>
@property(strong,nonatomic)estoreConnect*esConnect;
@property(strong,nonatomic)id<estoreManagerDelegate> delegate;
-(void)receiveData:(NSString*)idArea;
@end
