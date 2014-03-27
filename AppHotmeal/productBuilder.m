//
//  productBuilder.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "productBuilder.h"
#import "product.h"
@implementation productBuilder
+(NSArray*)getDataProduct:(NSData *)data error:(NSError **)error{
    NSError*err=nil;
    NSDictionary *parseObject=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&err];
    //NSLog(@"%@",parseObject);
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
            
            product *es=[[product alloc]init];
            [es setProperties:[rs objectForKey:@"properties"]];
            [es setStore_id:[rs objectForKey:@"store_id"]];
            [es setId:[rs objectForKey:@"id"]];
            [es setName:[rs objectForKey:@"name"]];
            [es setPrice:[rs objectForKey:@"price"]];
            [es setSale_price:[rs objectForKey:@"sale_price"]];
            //NSString *someString = [NSString stringWithFormat:@"%.0f VND", [es.price doubleValue]];
            NSArray*photos= [es.properties objectForKey:@"photos"];
            if([photos count]>0){
                NSString *img = [photos objectAtIndex:0];
                if(img !=NULL){
                    
                    [es setImage:[img stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    //NSLog(@"hinh anh cua es: %@",es.image);
                }
            }
            
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
