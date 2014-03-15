//
//  EstoreCell.h
//  Hotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstoreCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *open_hour;
@property (retain, nonatomic) IBOutlet UILabel *status;
@property (retain, nonatomic) IBOutlet UILabel *min_delivery;
@property (retain, nonatomic) IBOutlet UILabel *like;

@end
