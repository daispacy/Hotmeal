//
//  TimePickerViewController.m
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "TimePickerViewController.h"
@interface TimePickerViewController ()

@end

@implementation TimePickerViewController
@synthesize timePicker;
@synthesize time;
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
    //set current time;
    NSDate *Date=[NSDate date];
    self.timePicker.minimumDate=Date;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectTime:(id)sender {
    self.time=self.timePicker.date;
    [self.delegate getTime:self date:self.time];
    NSLog(@"%@",self.time);
}

@end
