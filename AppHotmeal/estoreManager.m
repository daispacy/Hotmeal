//
//  estoreManager.m
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//
#import "estoreManager.h"
#import "estoreBuilder.h"
#import "estoreConnect.h"

@implementation estoreManager
-(void)receiveData:(NSString *)idArea{
    NSLog(@"chay vao day roi");
    [self.esConnect getEstore:idArea];
}
-(void)getData:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[estoreBuilder getData:data error:&error];
    if(error!=nil){
        [self.delegate getDataFailed:error];
    }else{
        [self.delegate getData:estores];
    }
}
-(void)getDataFailed:(NSError *)error{
    [self.delegate getDataFailed:error];
}
@end
