//
//  estoreManagerDelegate.h
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol estoreManagerDelegate
-(void)getData:(NSArray*)data;
-(void)getDataFailed:(NSError*)error;
@end
