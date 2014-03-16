//
//  AlertViewController.m
//  AppHotmeal
//
//  Created by admin on 3/16/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController
@synthesize lblAlert;
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.lblAlert setText:[NSString stringWithFormat:@"%@",[self.delegate setAlert:self]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [lblAlert release];
    [super dealloc];
}
@end
