//
//  estoreConnect.m
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//


#import "estoreConnect.h"
#import "estoreDelegate.h"
#import "staticConfig.h"
#import "functions.h"


@implementation estoreConnect
-(void)getEstore:(NSString*)idArea page:(NSInteger)page{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&ida=%@&page=%@",HOST,API,OPLISTING,idArea,[functions convertFromNumberToString:page]];
    NSLog(@"request from estoreConnect: %@",urlString);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    [self.delegate getData:jsonData];
}
@end
