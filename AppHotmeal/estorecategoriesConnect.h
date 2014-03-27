//
//  estorecategoriesConnect.h
//  AppHotmeal
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol estorecategoriesDelegate;
@interface estorecategoriesConnect : NSObject
@property(strong,nonatomic)id<estorecategoriesDelegate> delegate;
-(void)getECate:(NSString*)ida;
@end
