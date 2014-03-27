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
#import "HUD.h"

@implementation estoreConnect
-(void)getEstore:(NSString*)idArea cid:(NSString*)cid page:(NSInteger)page kw:(NSString *)kw{
    //[HUD showUIBlockingIndicatorWithText:@"Loading..."];
    dispatch_async(kBgQueue, ^{
    
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&ida=%@&cid=%@&page=%@&kw=%@",HOST,API,OPLISTING,idArea,cid,[functions convertFromNumberToString:page],kw];
    
    NSLog(@"request from estoreConnect: %@",urlString);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"json estore: %@",jsonData);
            [self.delegate getData:jsonData];
           // [HUD hideUIBlockingIndicator];
            
            
        });
    });

}
@end
