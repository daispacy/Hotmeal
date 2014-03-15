//
//  orderaddressDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol orderaddressDelegate <NSObject>
-(void)getDataOrderAddress:(NSData*)data;
-(void)getDataOrderAddressFailed:(NSError*)error;
@end
