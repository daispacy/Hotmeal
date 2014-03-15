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
    id<AreaViewDelegate>delegate;
}
@property(assign,nonatomic)id<AreaViewDelegate>delegate;
@property (retain, nonatomic) IBOutlet UITableView *listArea;
@end
@protocol AreaViewDelegate<NSObject>
@optional
-(void)setIdAndNameArea:(AreaViewController*)controller idarea:(NSString*)id namearea:(NSString*)name;
@end