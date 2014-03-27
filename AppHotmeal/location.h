//
//  location.h
//  AppHotmeal
//
//  Created by admin on 3/20/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface location : NSObject<CLLocationManagerDelegate>
-(void)initLocation;
@property(strong,nonatomic)NSString*locality;
-(NSString*)getLocal;
@end
