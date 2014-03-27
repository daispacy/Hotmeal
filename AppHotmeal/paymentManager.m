//
//  paymentManager.m
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "paymentManager.h"
#import "paymentBuilder.h"
#import "paymentConnect.h"
@implementation paymentManager
-(void)receiveData:(NSString *)idEstore{
    NSLog(@"getting OrderAddress.....");
    [self.paymentConnect getPayment:idEstore];
}
-(void)getDataPayment:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[paymentBuilder getDataPayment:data error:&error];
    if(error!=nil){
        [self.delegate getDataPaymentFailed:error];
    }else{
        [self.delegate getDataPayment:estores];
    }
}
-(void)getDataPaymentFailed:(NSError *)error{
    [self.delegate getDataPaymentFailed:error];
}
@end
