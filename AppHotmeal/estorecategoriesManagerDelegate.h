//
//  estorecategoriesManagerDelegate.h
//  AppHotmeal
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol estorecategoriesManagerDelegate <NSObject>
-(void)getDataECate:(NSArray*)data;
-(void)getDataECateFailed:(NSError*)error;
@end
