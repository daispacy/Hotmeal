//
//  userManager.m
//  AppHotmeal
//
//  Created by admin on 3/13/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "userManager.h"
#import "userBuidler.h"
#import "userConnect.h"
@implementation userManager
-(void)receiveData:(NSString *)user password:(NSString *)password{
    NSLog(@"chay vao day roi");
    [self.userConnect getUsers:user password:password];
}
-(void)getDataUser:(NSData *)data{
    NSError *error=nil;
    NSArray *estores=[userBuidler getDataUser:data error:&error];
    if(error!=nil){
        [self.delegate getDataUserFailed:error];
    }else{
        [self.delegate getDataUser:estores];
    }
}
-(void)getDataUserFailed:(NSError *)error{
    [self.delegate getDataUserFailed:error];
}
@end
