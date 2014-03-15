//
//  productManager.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "productManager.h"
#import "productBuilder.h"
#import "productConnect.h"

@implementation productManager
-(void)receiveData:(NSString *)idEstore{
    NSLog(@"chay vao day roi");
    [self.proConnect getProducts:idEstore];
}
-(void)getDataProduct:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[productBuilder getDataProduct:data error:&error];
    if(error!=nil){
        [self.delegate getDataProductFailed:error];
    }else{
        [self.delegate getDataProduct:estores];
    }
}
-(void)getDataProductFailed:(NSError *)error{
    [self.delegate getDataProductFailed:error];
}
@end