//
//  MenuCategoriesViewController.h
//  AppHotmeal
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface MenuCategoriesViewController : UIViewController{
   
}
@property (strong, nonatomic) IBOutlet UITableView *tblEstoreCategories;
@property(strong,nonatomic)NSString*idArea;

- (IBAction)forwardToIndex:(id)sender;
@end
@protocol MenuCategoriesViewDelegate <NSObject>
@optional
- (NSString*)getIdAreaFromListingViewController:(MenuCategoriesViewController*)controller;
@end