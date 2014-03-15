//
//  productDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol productDelegate <NSObject>
-(void)getDataProduct:(NSData*)data;
-(void)getDataProductFailed:(NSError*)error;
@end
