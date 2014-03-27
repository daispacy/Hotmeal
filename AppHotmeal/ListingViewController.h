//
//  ListingViewController.h
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingViewController : UIViewController{
    
}

@property(nonatomic,strong)NSString* cId;
@property(nonatomic,strong)NSString* idArea;
@property(nonatomic,strong)NSString*_nameArea;
@property(nonatomic,strong)NSMutableArray* idEstore;
@property(nonatomic,assign)NSInteger pages;
@property(nonatomic,assign)NSInteger page;
@property (nonatomic, strong) UILabel *footerLabel;
@property (strong, nonatomic) IBOutlet UITableView *tblListing;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property(assign,nonatomic)NSInteger totalSize;
@property(strong,nonatomic)NSString*_kw;
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearch;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
