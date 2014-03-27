//
//  TimePickerViewController.h
//  AppHotmeal
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TimePickerViewDelegate;
@interface TimePickerViewController : UIViewController{
    
}
@property(strong,nonatomic)id<TimePickerViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
- (IBAction)selectTime:(id)sender;
@property(weak,nonatomic)NSDate*time;

@end
@protocol TimePickerViewDelegate<NSObject>
@optional
- (void)getTime:(TimePickerViewController*)controller date:(NSDate*)date;
@end
