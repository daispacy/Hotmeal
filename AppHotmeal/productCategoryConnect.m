//
//  productCategoryConnect.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "productCategoryConnect.h"
#import "productCategoryDelegate.h"
#import "staticConfig.h"

@implementation productCategoryConnect
-(void)getProductCategories:(NSString *)idEstore{
    NSString* urlString=[NSString stringWithFormat:@"%@apikey=%@&op=%@&id=%@",HOST,API,OPPRODUCTCATEGORIES,idEstore];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    [self.delegate getProductCate:jsonData];
}

@end
