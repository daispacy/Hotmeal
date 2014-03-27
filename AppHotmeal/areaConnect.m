//
//  areaConnect.m
//  AppHotmeal
//
//  Created by admin on 3/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "areaConnect.h"
#import "areaDelegate.h"
#import "staticConfig.h"
#import "HUD.h"

@implementation areaConnect
-(void)getArea{
    [HUD showUIBlockingIndicatorWithText:@"Loading..."];
    dispatch_async(kBgQueue, ^{
        NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@",HOST,API,OPAREA];
        NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate getDataArea:jsonData];
            [HUD hideUIBlockingIndicator];
        
        
       });
    });
    
}

@end
