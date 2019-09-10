//
//  AppDelegate.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/6/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = UIWindow.new;
    [self.window makeKeyAndVisible];
    
    UINavigationController *nc = UINavigationController.new;
    ViewController *vc = ViewController.new;
    self.window.rootViewController = [nc initWithRootViewController:vc];
    
    return YES;
}

@end
