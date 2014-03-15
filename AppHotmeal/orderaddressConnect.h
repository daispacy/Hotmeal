//
//  orderaddressConnect.h
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol orderaddressDelegate;
@interface orderaddressConnect : NSObject
@property(strong,nonatomic)id<orderaddressDelegate> delegate;
-(void)getOrderAddress:(NSString*)idEstore idarea:(NSString*)idArea;
@end
