//
//  AppDelegate.h
//  RC Plane Garage
//
//  Created by Michael Smith on 1/21/14.
//  Copyright (c) 2014 Michael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;



@end
