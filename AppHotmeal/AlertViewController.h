//
//  AlertViewController.h
//  AppHotmeal
//
//  Created by admin on 3/16/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AlertViewDelegate;
@interface AlertViewController : UIViewController{
    id<AlertViewDelegate>__weak delegate;
}
@property(weak,nonatomic)id<AlertViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UILabel *lblAlert;
@end
@protocol AlertViewDelegate<NSObject>
@optional
-(NSString*)setAlert:(AlertViewController*)controller;

@end