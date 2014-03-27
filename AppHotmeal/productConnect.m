//
//  productConnect.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "productConnect.h"
#import "productDelegate.h"
#import "staticConfig.h"
#import "HUD.h"

@implementation productConnect
-(void)getProducts:(NSString *)idEstore{
    [HUD showUIBlockingIndicatorWithText:@"Loading..."];
    dispatch_async(kBgQueue, ^{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&id=%@",HOST,API,OPPRODUCTS,idEstore];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate getDataProduct:jsonData];
            [HUD hideUIBlockingIndicator];
        });
    });
}

@end
