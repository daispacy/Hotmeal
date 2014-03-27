//
//  checkInternet.m
//  AppHotmeal
//
//  Created by admin on 3/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "checkInternet.h"
#import "Reachability.h"
#import "staticConfig.h"
#import "functions.h"
#import "UIViewController+MJPopupViewController.h"
#import "HUD.h"

@implementation checkInternet
+(BOOL)testInternetConnection
{
    BOOL flag;
    Reachability *internetReachableFoo;
    internetReachableFoo = [Reachability reachabilityWithHostname:@"http://hotmeal.vn"];
    //internetReachableFoo = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReachableFoo currentReachabilityStatus];
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            flag=TRUE;
            //[HUD hideUIBlockingIndicator];
            break;
        }
        case ReachableViaWiFi:
        {
            flag=TRUE;
            //[HUD hideUIBlockingIndicator];
            break;
        }
        case NotReachable:
        {
            flag=FALSE;
            //[HUD showUIBlockingIndicatorWithText:@"connect..."];
            //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Lỗi kết nối mạng." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //[alert show];
            break;
        }
            
    }
    internetReachableFoo = [Reachability reachabilityWithHostname:@"http://hotmeal.vn"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
            [HUD hideUIBlockingIndicator];
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD showUIBlockingIndicatorWithText:@"connect..."];
            NSLog(@"Someone broke the internet :(");
        });
    };
    
    [internetReachableFoo startNotifier];
    return flag;
}
@end
