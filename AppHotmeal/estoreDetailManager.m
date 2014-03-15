//
//  estoreDetailManager.m
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "estoreDetailManager.h"
#import "estoreDetailBuilder.h"
#import "estoreDetailConnect.h"
@implementation estoreDetailManager
-(void)receiveData:(NSString *)idEstore{
    NSLog(@"chay vao day roi");
    [self.esConnect getEstore:idEstore];
}
-(void)getData:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[estoreDetailBuilder getData:data error:&error];
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
