//
//  AppDelegate.m
//  RC Plane Garage
//
//  Created by Michael Smith on 1/21/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AddPlaneViewController.h"
#import "EditPlaneViewController.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"aV2YaiwbYmi0dK3YLeOLlRGFVsXR7T5ddFNenXEJ"
                  clientKey:@"fPA6N5YVouV1DxVNUqo0wfFWxp4UD6jVf4YfPZPb"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController *viewController1 = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController1];
    UIViewController *editController = [[EditPlaneViewController alloc] initWithNibName:@"EditPlaneViewController" bundle:nil];
    UIViewController *addController = [[AddPlaneViewController alloc] initWithNibName:@"AddPlaneViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.viewControllers = @[navController, editController, addController];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
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
