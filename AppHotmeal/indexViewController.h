//
//  indexViewController.h
//  AppHotmeal
///Users/admin/Desktop/newfile/ViewController.h
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaViewController.h"
@interface indexViewController : UIViewController{
    IBOutlet UIButton *btnNext;
}

@property (strong, nonatomic) IBOutlet UITableView *selectArea;
- (IBAction)btnNext:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property(strong,nonatomic)NSString*idA;
@property(strong,nonatomic)NSString*nameArea;
@property(strong,nonatomic)AreaViewController*_areaViewController;
@property(strong,nonatomic)NSArray*listArea;
@end