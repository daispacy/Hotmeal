//
//  userBuidler.m
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "userBuidler.h"
#import "user.h"
@implementation userBuidler
+(NSArray*)getDataUser:(NSData *)data error:(NSError **)error{
    NSError*err=nil;
    NSDictionary *parseObject=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&err];
    NSLog(@"dang o user builder%@",parseObject);
    if(err!=nil){
        *error=err;
        return nil;
    }
    // NSArray *results = [parseObject allValues];
    //NSLog(@"Count %d", parseObject.count);
    //NSLog(@"%@",parseObject);
    NSMutableArray *estores=[[NSMutableArray alloc]init];
            
        user *es=[[user alloc]init];
        [es setAddress:[parseObject objectForKey:@"address"]];
        [es setId:[parseObject objectForKey:@"id"]];
        [es setName:[parseObject objectForKey:@"username"]];
        [es setFullname:[parseObject objectForKey:@"name"]];
        [es setEmail:[parseObject objectForKey:@"email"]];
        [es setPhone:[parseObject objectForKey:@"phone"]];
        [es setArea_id:[[parseObject objectForKey:@"area_id"] doubleValue]];
        [es setError:[parseObject objectForKey:@"error"]];
        [es setMessage:[parseObject objectForKey:@"message"]];
        [estores addObject:es];
    
    return estores;
}

@end
