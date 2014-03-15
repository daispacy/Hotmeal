//
//  orderaddressConnect.m
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "orderaddressConnect.h"

#import "orderaddressConnect.h"
#import "orderaddressDelegate.h"
#define API @"87banhvantran"
#define HOST @"http://hotmeal.vn/iosgate.php?"
#define OP @"feedelivery"
@implementation orderaddressConnect
-(void)getOrderAddress:(NSString *)idEstore idarea:(NSString *)idArea{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&id=%@&ida=%@",HOST,API,OP,idEstore,idArea];
    NSLog(@"url: %@",urlString);
    NSURL* url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
    //NSLog(@"lok get duoc data :%@",data);
    [self.delegate getDataOrderAddress:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    NSLog(@"loi roi");
    [self.delegate getDataOrderAddressFailed:error];
}
@end