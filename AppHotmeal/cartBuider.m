//
//  cartBuider.m
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "cartBuider.h"
#import "statusCart.h"
@implementation cartBuider
+(NSArray*)getDataCart:(NSData *)data error:(NSError **)error{
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
    @try {
        statusCart *es=[[statusCart alloc]init];
        [es setError:[parseObject objectForKey:@"error"]];
        [es setMessage:[parseObject objectForKey:@"message"]];
        [estores addObject:es];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        return estores;
    }
    
    
    
}

@end