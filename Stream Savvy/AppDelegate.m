//
//  AppDelegate.m
//  Stream Savvy
//
//  Created by Allen White on 8/10/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Lock/Lock.h>
#import "Stream_Savvy-Swift.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // Override point for customization after application launch.
        [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [[A0Lock sharedLock] applicationLaunchedWithOptions:launchOptions];
    
    //Harpy
    
    [self.window makeKeyAndVisible];
    
    [[Harpy sharedInstance] setPresentingViewController:_window.rootViewController];
    
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeForce];
    
    NSString *model = [[UIDevice currentDevice] model];
    
        //device is simulator
    [[Harpy sharedInstance] setDelegate:self];

    [[Harpy sharedInstance] setPatchUpdateAlertType:HarpyAlertTypeSkip];
    [[Harpy sharedInstance] setMinorUpdateAlertType:HarpyAlertTypeOption];
    [[Harpy sharedInstance] setMajorUpdateAlertType:HarpyAlertTypeForce];
    [[Harpy sharedInstance] setRevisionUpdateAlertType:HarpyAlertTypeOption];
    
    
    [[Harpy sharedInstance] checkVersion];
    
        
    
    
        
        return YES;
}

- (void)harpyUserDidSkipVersion{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UITabBarController *destCon = [storyboard instantiateViewControllerWithIdentifier:@"Auth0ViewController"];
    //    destCon.event=notifyEvent;
    //    UINavigationController *navController =(UINavigationController *) self.window.rootViewController;
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:destCon animated:YES completion:nil];
}

// User did click on button that cancels update dialog
- (void)harpyUserDidCancel{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UITabBarController *destCon = [storyboard instantiateViewControllerWithIdentifier:@"Auth0ViewController"];
//    destCon.event=notifyEvent;
//    UINavigationController *navController =(UINavigationController *) self.window.rootViewController;
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:destCon animated:YES completion:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
        
//        BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                                      openURL:url
//                                                            sourceApplication:sourceApplication
//                                                                   annotation:annotation
//                        ];
        // Add any custom logic here.
        return  [[A0Lock sharedLock] handleURL:url sourceApplication:sourceApplication];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
        
        return [[A0Lock sharedLock] continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (void)applicationWillResignActive:(UIApplication *)application {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[Harpy sharedInstance] checkVersionDaily];
    [[[SocketIOManager alloc] init] echoTest];
}

- (void)applicationWillTerminate:(UIApplication *)application {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
