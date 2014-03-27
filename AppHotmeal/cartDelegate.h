//
//  cart.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol cartDelegate <NSObject>
-(void)getDataCart:(NSData*)data;
-(void)getDataCartFailed:(NSError*)error;
@end
