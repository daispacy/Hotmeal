//
//  estoreDetailManagerDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol estoreDetailManagerDelegate
-(void)getData:(NSArray*)data;
-(void)getDataFailed:(NSError*)error;
@end
