//
//  indexViewController.h
//  AppHotmeal
///Users/admin/Desktop/newfile/ViewController.h
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface indexViewController : UIViewController{
    IBOutlet UIButton *btnNext;
}

@property (retain, nonatomic) IBOutlet UITableView *selectArea;
- (IBAction)btnNext:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnNext;
@property(strong,nonatomic)NSString*idA;
@property(strong,nonatomic)NSString*nameArea;
@end