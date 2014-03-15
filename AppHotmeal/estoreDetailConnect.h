//
//  estoreDetailConnect.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol estoreDetailDelegate;
@interface estoreDetailConnect : NSObject
@property(strong,nonatomic)id<estoreDetailDelegate> delegate;
-(void)getEstore:(NSString*)idEstore;
@end
