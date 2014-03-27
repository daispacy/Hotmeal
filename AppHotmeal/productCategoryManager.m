//
//  productCategoryManager.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "productCategoryManager.h"
#import "productCategoryBuilder.h"
#import "productCategoryConnect.h"

@implementation productCategoryManager
-(void)receiveData:(NSString *)idEstore{
    NSLog(@"chay vao day roi");
    [self.proCateConnect getProductCategories:idEstore];
}
-(void)getProductCate:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[productCategoryBuilder getDataProductCate:data error:&error];
    if(error!=nil){
        [self.delegate getDataProductCateFailed:error];
    }else{
        [self.delegate getDataProductCate:estores];
    }
}
-(void)getProductCateFailed:(NSError *)error{
    [self.delegate getDataProductCateFailed:error];
}
@end

