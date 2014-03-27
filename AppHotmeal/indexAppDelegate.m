//
//  indexAppDelegate.m
//  AppHotmeal
//
//  Created by admin on 3/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "indexAppDelegate.h"
#import "userDAO.h"
#import "loginViewController.h"
#import "indexViewController.h"
#import "checkInternet.h"
@implementation indexAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*test 1 so thu
   
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Doing something...");
    }];
    
    //you can add more blocks
    [operation addExecutionBlock:^{
        NSLog(@"Another block");
    }];
    
    [operation setCompletionBlock:^{
        NSLog(@"Doing something once the operation has finished...");
    }];
    
    [queue addOperation:operation];
    
    end test */
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    loginViewController *one = [sb instantiateViewControllerWithIdentifier:@"login"];
    indexViewController *two = [sb instantiateViewControllerWithIdentifier:@"index"];
    
    // Override point for customization after application launch.
    userDAO*_userDao=[[userDAO alloc]init];
    NSLog([_userDao isUser]?@"TRUE":@"FALSE");
    if ([_userDao isUser]) {
        self.window.rootViewController=two;
        [self.window makeKeyAndVisible];
    } else {
        self.window.rootViewController=one;
        [self.window makeKeyAndVisible];
    }
    [checkInternet testInternetConnection];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
