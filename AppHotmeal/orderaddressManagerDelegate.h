//
//  orderaddressManagerDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol orderaddressManagerDelegate <NSObject>
-(void)getDataOrderAddress:(NSArray*)data;
-(void)getDataOrderAddressFailed:(NSError*)error;
@end
