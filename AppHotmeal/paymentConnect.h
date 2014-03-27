//
//  paymentConnect.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol paymentDelegate;
@interface paymentConnect : NSObject
@property(strong,nonatomic)id<paymentDelegate> delegate;
-(void)getPayment:(NSString*)idEstore;
@end
