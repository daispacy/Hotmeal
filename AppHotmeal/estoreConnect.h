//
//  estoreConnect.h
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol estoreDelegate;
@interface estoreConnect : NSObject
@property(strong,nonatomic)id<estoreDelegate> delegate;
-(void)getEstore:(NSString*)idArea;
@end
