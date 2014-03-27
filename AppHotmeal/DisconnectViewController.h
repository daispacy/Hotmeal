//
//  DisconnectViewController.h
//  AppHotmeal
//
//  Created by admin on 3/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DisconnectViewDelegate;
@interface DisconnectViewController : UIViewController{
    id<DisconnectViewDelegate>delegate;
}
@property(strong,nonatomic)id<DisconnectViewDelegate>delegate;
@end
