//
//  estorecategoriesConnect.m
//  AppHotmeal
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "estorecategoriesConnect.h"
#import "estorecategoriesDelegate.h"
#import "staticConfig.h"

@implementation estorecategoriesConnect
-(void)getECate:(NSString *)ida{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&ida=%@",HOST,API,OPESTORECATEGORIES,ida];
    NSLog(@"%@",urlString);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    [self.delegate getDataECate:jsonData];
}
@end
