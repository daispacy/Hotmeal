//
//  estoreDelegate.h
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol estoreDelegate
-(void)getData:(NSData*)data;
-(void)getDataFailed:(NSError*)error;
@end
