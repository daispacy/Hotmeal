//
//  estorecategoriesManager.m
//  AppHotmeal
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "estorecategoriesManager.h"
#import "estorecategoriesBuilder.h"
#import "estorecategoriesConnect.h"

@implementation estorecategoriesManager
-(void)receiveDataECate:(NSString*)ida{
    NSLog(@"chay vao day roi");
    [self.ecConnect getECate:ida];
}
-(void)getDataECate:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[estorecategoriesBuilder getDataECate:data error:&error];
    if(error!=nil){
        [self.delegate getDataECateFailed:error];
    }else{
        [self.delegate getDataECate:estores];
    }
}
-(void)getDataECateFailed:(NSError *)error{
    [self.delegate getDataECateFailed:error];
}
@end
