//
//  estoreDetailManager.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "estoreDetailManagerDelegate.h"
#import "estoreDetailDelegate.h"
@class estoreDetailConnect;
@interface estoreDetailManager : NSObject<estoreDetailDelegate>
@property(strong,nonatomic)estoreDetailConnect*esConnect;
@property(strong,nonatomic)id<estoreDetailManagerDelegate> delegate;
-(void)receiveData:(NSString*)idEstore;
@end

