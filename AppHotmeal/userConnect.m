//
//  userConnect.m
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "userConnect.h"
#import "userDelegate.h"
#define API @"87banhvantran"
#define HOST @"http://hotmeal.vn/iosgate.php?"
#define OP @"login"
@implementation userConnect
-(void)getUsers:user password:(NSString *)password{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&user=%@&password=%@",HOST,API,OP,user,password];
    NSLog(@"url: %@",urlString);
    NSURL* url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
    //NSLog(@"lok get duoc data :%@",data);
    [self.delegate getDataUser:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    NSLog(@"loi roi");
    [self.delegate getDataUserFailed:error];
}
@end