//
//  paymentManagerDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol paymentManagerDelegate <NSObject>
-(void)getDataPayment:(NSArray*)data;
-(void)getDataPaymentFailed:(NSError*)error;
@end
