//
//  estorecategoriesBuilder.m
//  AppHotmeal
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "estorecategoriesBuilder.h"
#import "estorecategories.h"
@implementation estorecategoriesBuilder
+(NSArray*)getDataECate:(NSData *)data error:(NSError **)error{
    NSError*err=nil;
    NSDictionary *parseObject=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&err];
    //NSLog(@"%@",parseObject);
    if(err!=nil){
        *error=err;
        return nil;
    }
    //NSArray *results = [parseObject allValues];
    //NSLog(@"Count %d", parseObject.count);
    
    NSMutableArray *estores=[[NSMutableArray alloc]init];
    @try {
        for (NSDictionary* rs in parseObject) {
            estorecategories *es=[[estorecategories alloc]init];
            [es setId:[rs objectForKey:@"id"]];
            [es setVn_name:[rs objectForKey:@"vn_name"]];
            [es setEn_name:[rs objectForKey:@"en_name"]];
            [es setError:[rs objectForKey:@"error"]];
            [es setMessage:[rs objectForKey:@"message"]];
            [estores addObject:es];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        return estores;
    }
    
    
}

@end
