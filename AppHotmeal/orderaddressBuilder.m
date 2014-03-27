//
//  orderaddressBuilder.m
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "orderaddressBuilder.h"
#import "orderaddress.h"
@implementation orderaddressBuilder
+(NSArray*)getDataOrderAddress:(NSData *)data error:(NSError **)error{
    NSError*err=nil;
    NSDictionary *parseObject=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&err];
    NSLog(@"%@",parseObject);
    if(err!=nil){
        *error=err;
        return nil;
    }
    // NSArray *results = [parseObject allValues];
    //NSLog(@"Count %d", parseObject.count);
    //NSLog(@"%@",parseObject);
    NSMutableArray *estores=[[NSMutableArray alloc]init];
    @try {
        for (NSDictionary* rs in parseObject) {
            orderaddress *es=[[orderaddress alloc]init];
            [es setName:[rs objectForKey:@"name"]];
            [es setAddress:[rs objectForKey:@"address"]];
            [es setId:[rs objectForKey:@"id"]];
            [es setSid:[rs objectForKey:@"sid"]];
            [es setFree_delivery:[[rs objectForKey:@"free_delivery"] doubleValue]];
            [es setMini_delivery:[[rs objectForKey:@"mini_delivery"] doubleValue]];
            [es setPrice:[[rs objectForKey:@"price"] doubleValue]];
            [es setTimes:[rs objectForKey:@"times"]];
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