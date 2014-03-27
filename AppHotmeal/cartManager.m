//
//  cartManager.m
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "cartManager.h"
#import "cartBuider.h"
#import "cartConnect.h"
@implementation cartManager
-(void)processCart:(NSString *)post{
    [self.crConnect processOrder:post];
}
-(void)getDataCart:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[cartBuider getDataCart:data error:&error];
    if(error!=nil){
        [self.delegate getDataCartFailed:error];
    }else{
        [self.delegate getDataCart:estores];
    }
}
-(void)getDataCartFailed:(NSError *)error{
    [self.delegate getDataCartFailed:error];
}
@end