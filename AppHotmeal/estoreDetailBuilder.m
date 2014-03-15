//
//  estoreDetailBuilder.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "estoreDetailBuilder.h"
#import "estoreDetail.h"
@implementation estoreDetailBuilder
+(NSArray*)getData:(NSData *)data error:(NSError **)error{
    NSError*err=nil;
    NSDictionary *parseObject=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&err];
    //NSLog(@"%@",parseObject);
    if(err!=nil){
        *error=err;
        return nil;
    }
    //NSArray *results = [parseObject allValues];
    //NSLog(@"Count %d", results.count);
    
    NSMutableArray *estores=[[NSMutableArray alloc]init];
  
        estoreDetail *es=[[estoreDetail alloc]init];
        [es setProperties:[parseObject objectForKey:@"image"]];
        [es setProperties:[parseObject objectForKey:@"properties"]];
        [es setVn_name:[parseObject objectForKey:@"vn_name"]];
        [es setAddress:[parseObject objectForKey:@"address"]];
        [es setEn_name:[parseObject objectForKey:@"en_name"]];
        [es setVn_description:[parseObject objectForKey:@"vn_description"]];
        [es setImage:[[es.properties objectForKey:@"avatar"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [estores addObject:es];
    return estores;
}
@end
