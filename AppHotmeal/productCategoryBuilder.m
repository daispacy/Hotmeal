//
//  productCategoryBuilder.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "productCategoryBuilder.h"
#import "productCategory.h"
@implementation productCategoryBuilder
+(NSArray*)getDataProductCate:(NSData *)data error:(NSError **)error{
    NSError*err=nil;
    NSDictionary *parseObject=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&err];
    NSLog(@"%@",parseObject);
    if(err!=nil){
        *error=err;
        return nil;
    }
    //NSArray *results = [parseObject allValues];
    //NSLog(@"Count %d", parseObject.count);
    
    NSMutableArray *estores=[[NSMutableArray alloc]init];
    for (NSDictionary* rs in parseObject) {
        productCategory *es=[[productCategory alloc]init];
        [es setId:[rs objectForKey:@"id"]];
        [es setName:[rs objectForKey:@"name"]];
        [estores addObject:es];
    }
    return estores;
}

@end
