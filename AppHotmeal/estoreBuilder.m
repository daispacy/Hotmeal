//
//  estoreBuilder.m
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "estoreBuilder.h"
#import "estore.h"
@implementation estoreBuilder
+(NSArray*)getData:(NSData *)data error:(NSError **)error{
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
    for (NSDictionary* rs in parseObject) {
        
            estore *es=[[estore alloc]init];
        
            NSString*image = [rs objectForKey:@"image"];
        
            [es setImage:[image stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
       
            [es setId:[rs objectForKey:@"id"]];
       
            [es setName:[rs objectForKey:@"name"]];
       
            [es setMessage:[rs objectForKey:@"message"]];
       
           NSString*pages = [rs objectForKey:@"pages"];
       
            [es setPages:[pages doubleValue]];
      
            NSString* like = [rs objectForKey:@"like"];
     
            [es setLike:[like doubleValue]];
     
            [es setListime:[rs objectForKey:@"listime"]];
  
            NSString* status = [rs objectForKey:@"status"];
      
            [es setStatus:[status doubleValue]];
      
            [es setMin_delivery:[rs objectForKey:@"mini_delivery"]];
     
        NSString*total = [rs objectForKey:@"total"];
    
            [es setTotal:[total doubleValue]];
    
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
