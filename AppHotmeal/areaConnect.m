//
//  areaConnect.m
//  AppHotmeal
//
//  Created by admin on 3/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "areaConnect.h"
#import "areaDelegate.h"
#define API @"87banhvantran"
#define HOST @"http://hotmeal.vn/iosgate.php?"
#define OP @"area"

@implementation areaConnect
-(void)getArea{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@",HOST,API,OP];
    NSLog(@"url: %@",urlString);
    NSURL* url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
    //NSLog(@"lok get duoc data :%@",data);
    [self.delegate getDataArea:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    NSLog(@"loi roi");
    [self.delegate getDataAreaFailed:error];
}

@end
