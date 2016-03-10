//
//  AppDelegate.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-12.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "AppDelegate.h"
#import "WFAsyncHttp.h"
#import "ViewController.h"
#import <objc/runtime.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
#warning 网页缓存要设置这个，而且必须放在这
    [WFAsyncURLCache setURLCache];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    ViewController *vc = [ViewController new];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    NSString *str1 = @"fadf";
    NSString *str2 = @"wolvesqujn";
    
    size_t size1 = class_getInstanceSize(str1.class);
    size_t size2 = class_getInstanceSize(str2.class);
    

    
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

+ (void)showLog:(id)obj
{
    NSLog(@"log ========> %@", obj);
}

+ (void)showAlert:(NSString *)log
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:log delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil , nil];
    [alertView show];
}

@end
