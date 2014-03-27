//
//  AreaViewController.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AreaViewDelegate;
@interface AreaViewController : UIViewController{
    id<AreaViewDelegate>__weak delegate;
}
@property(weak,nonatomic)id<AreaViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *listArea;
@property(strong,nonatomic)NSArray*arrArea;
@end
@protocol AreaViewDelegate<NSObject>
@optional
-(void)setIdAndNameArea:(AreaViewController*)controller idarea:(NSString*)id namearea:(NSString*)name;
-(NSArray*)getArrayArea;
@end