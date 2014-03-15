//
//  productCategoryConnect.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "productCategoryConnect.h"
#import "productCategoryDelegate.h"
#define API @"87banhvantran"
#define HOST @"http://hotmeal.vn/iosgate.php?"
#define OP @"productcategories"
@implementation productCategoryConnect
-(void)getProductCategories:(NSString *)idEstore{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&id=%@",HOST,API,OP,idEstore];
    NSLog(@"url: %@",urlString);
    NSURL* url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
    //NSLog(@"lok get duoc data :%@",data);
    [self.delegate getProductCate:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    NSLog(@"loi roi");
    [self.delegate getProductCateFailed:error];
}
@end
