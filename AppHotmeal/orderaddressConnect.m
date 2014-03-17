//
//  orderaddressConnect.m
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "orderaddressConnect.h"
#import "orderaddressDelegate.h"
#import "staticConfig.h"


@implementation orderaddressConnect
-(void)getOrderAddress:(NSString *)idEstore idarea:(NSString *)idArea{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&id=%@&ida=%@",HOST,API,OPFEEDELIVERY,idEstore,idArea];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    [self.delegate getDataOrderAddress:jsonData];
}

@end