//
//  PaymentViewController.h
//  AppHotmeal
//
//  Created by admin on 3/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "payment.h"
@protocol PaymentViewDelegate;
@interface PaymentViewController : UIViewController{
    id<PaymentViewDelegate>delegate;
}
@property (retain, nonatomic) IBOutlet UITableView *tblPayment;
@property(assign,nonatomic)id<PaymentViewDelegate>delegate;
@property(strong,nonatomic)NSString*idEstore;
@end
@protocol PaymentViewDelegate<NSObject>
@optional
- (NSString*)getIdEstoreFromPaymentViewController:(PaymentViewController*)controller;
-(void)setIdAndNamePayment:(PaymentViewController*)controller payment:(payment*)object;
@end