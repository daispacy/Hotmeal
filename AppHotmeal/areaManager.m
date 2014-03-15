//
//  areaManager.m
//  AppHotmeal
//
//  Created by admin on 3/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "areaManager.h"
#import "areaBuilder.h"
#import "areaConnect.h"

@implementation areaManager
-(void)receiveDataArea{
    NSLog(@"chay vao day roi");
    [self.esConnect getArea];
}
-(void)getDataArea:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[areaBuilder getDataArea:data error:&error];
    if(error!=nil){
        [self.delegate getDataAreaFailed:error];
    }else{
        [self.delegate getDataArea:estores];
    }
}
-(void)getDataAreaFailed:(NSError *)error{
    [self.delegate getDataAreaFailed:error];
}
@end

