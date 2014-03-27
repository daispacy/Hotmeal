//
//  orderaddressManager.m
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "orderaddressManager.h"
#import "orderaddressBuilder.h"
#import "orderaddressConnect.h"
@implementation orderaddressManager
-(void)receiveData:(NSString *)idEstore idarea:(NSString *)idArea{
    NSLog(@"getting OrderAddress.....");
    [self.odConnect getOrderAddress:idEstore idarea:idArea];
}
-(void)getDataOrderAddress:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[orderaddressBuilder getDataOrderAddress:data error:&error];
    if(error!=nil){
        [self.delegate getDataOrderAddressFailed:error];
    }else{
        [self.delegate getDataOrderAddress:estores];
    }
}
-(void)getDataOrderAddressFailed:(NSError *)error{
    [self.delegate getDataOrderAddressFailed:error];
}
@end
