//
//  CartCell.h
//  AppHotmeal
//
//  Created by admin on 3/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameProduct;
@property (strong, nonatomic) IBOutlet UITextField *quantity;
@property (strong, nonatomic) IBOutlet UILabel *price;

- (IBAction)checkPrice:(id)sender;
@end
