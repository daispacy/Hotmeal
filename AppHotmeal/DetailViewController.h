//
//  DetailViewController.h
//  AppHotmeal
//
//  Created by admin on 3/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartViewController.h"
@interface DetailViewController : UIViewController<ShoppingCartViewContrllerDelegate>{
    
}
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (retain, nonatomic) IBOutlet UILabel *txtName;
@property (retain, nonatomic) IBOutlet UITableView *productView;
@property (retain, nonatomic) IBOutlet UILabel *txtDescription;
@property(strong,nonatomic)NSString *idEstore;
@property(strong,nonatomic)NSString*idArea;
@property(strong,nonatomic)NSMutableArray *productInCart;
@property(assign,nonatomic)NSInteger totalCart;
@property(strong,nonatomic)NSString*nameArea;
@property(assign,nonatomic)NSInteger status;
@end
