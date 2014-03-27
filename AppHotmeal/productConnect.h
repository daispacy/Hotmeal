//
//  productConnect.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol productDelegate;
@interface productConnect : NSObject
@property(strong,nonatomic)id<productDelegate> delegate;
-(void)getProducts:(NSString*)idEstore;

@end
