//
//  estoreConnect.m
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//


#import "estoreConnect.h"
#import "estoreDelegate.h"
#define API @"87banhvantran"
#define HOST @"http://hotmeal.vn/iosgate.php?"
#define OP @"listing"

@implementation estoreConnect
-(void)getEstore:(NSString*)idArea{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&ida=%@",HOST,API,OP,idArea];
    NSLog(@"url: %@",urlString);
    NSURL* url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
   //NSLog(@"lok get duoc data :%@",data);
    [self.delegate getData:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    NSLog(@"loi roi");
    [self.delegate getDataFailed:error];
}

@end
