//
//  ProductCell.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imageProduct;
@property (retain, nonatomic) IBOutlet UILabel *nameProduct;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UIButton *btn;

@end
