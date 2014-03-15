//
//  productConnect.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "productConnect.h"
#import "productDelegate.h"
#define API @"87banhvantran"
#define HOST @"http://hotmeal.vn/iosgate.php?"
#define OP @"products"
@implementation productConnect
-(void)getProducts:(NSString *)idEstore{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&id=%@",HOST,API,OP,idEstore];
    NSLog(@"url: %@",urlString);
    NSURL* url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
    //NSLog(@"lok get duoc data :%@",data);
    [self.delegate getDataProduct:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    NSLog(@"loi roi");
    [self.delegate getDataProductFailed:error];
}
@end
