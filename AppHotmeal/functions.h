//
//  functions.h
//  AppHotmeal
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface functions : NSObject


//doi dinh dang chuoi sang dinh dang so
+(NSString*)convertFromNumberToString:(NSInteger)number;

//kiem tra email hop le
+(BOOL)validateEmail:(NSString*)string;

//kiem tra co phai la so
+(BOOL)validateNumber:(NSString*)test;

//kiem tra du textfield vao co rong khong
+(BOOL)validateInput:(UITextField*)textFeild length:(NSInteger)length;

//kiem tra password co trung nhau khong
+(BOOL)validateRetypePassword:(NSString*)password retypepassword:(NSString*)retypepassword;

//kiem tra password co hop le
+(BOOL)validatePassword:(NSString*)password;

//hien alert voi tin nhan
+(void)alert:(NSString*)message title:(NSString*)title buttonTitle:(NSString*)btnTitle controller:(UIViewController*)controller;
+(void)alertOKCancel:(NSString*)message title:(NSString*)title buttonOK:(NSString*)btnTitle buttonCancel:(NSString*)btnTitle controller:(UIViewController*)controller;

//chuyen date sang chuoi
+(NSString*)convertDateToString:(NSDate*)date;
@end
