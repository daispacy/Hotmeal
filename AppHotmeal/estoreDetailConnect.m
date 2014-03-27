//
//  estoreDetailConnect.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "estoreDetailConnect.h"
#import "estoreDetailDelegate.h"
#import "staticConfig.h"

@implementation estoreDetailConnect
-(void)getEstore:(NSString*)idEstore{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&id=%@",HOST,API,OPESTOREDETAIL,idEstore];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    [self.delegate getData:jsonData];
}
@end
