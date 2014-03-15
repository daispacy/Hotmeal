//
//  paymentBuilder.m
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "paymentBuilder.h"
#import "payment.h"
@implementation paymentBuilder
+(NSArray*)getDataPayment:(NSData *)data error:(NSError **)error{
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
    for (NSDictionary* rs in parseObject) {
        payment *es=[[payment alloc]init];
        [es setName:[rs objectForKey:@"name"]];
        [es setId:[rs objectForKey:@"Id"]];
        [es setFee:[[rs objectForKey:@"fee"] doubleValue]];
        [estores addObject:es];
    }
    return estores;
}

@end
