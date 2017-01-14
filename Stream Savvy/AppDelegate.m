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
#import "Amplitude.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <TwitterKit/TwitterKit.h>
#import <AWSCognito/AWSCognito.h>

#import <MoPub/MoPub.h>



@interface AppDelegate()




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
    [[Harpy sharedInstance] setMinorUpdateAlertType:HarpyAlertTypeForce];
    [[Harpy sharedInstance] setMajorUpdateAlertType:HarpyAlertTypeForce];
    [[Harpy sharedInstance] setRevisionUpdateAlertType:HarpyAlertTypeOption];
    
    
    [[Harpy sharedInstance] checkVersion];
    
    
    
    [Fabric with:@[[Twitter class],[Answers class], [Crashlytics class], [MoPub class], [AWSCognito class]]];
    
    UIUserNotificationType types = (UIUserNotificationTypeBadge | UIUserNotificationTypeSound |
                                    UIUserNotificationTypeAlert);
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    // In iOS 8, this is when the user receives a system prompt for notifications in your app
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];

#pragma mark pushbots
    
    self.PushbotsClient = [[Pushbots alloc] initWithAppId:@"583b93704a9efa50c08b4568" prompt:YES];
    [self.PushbotsClient trackPushNotificationOpenedWithLaunchOptions:launchOptions];
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        //Check for openURL [optional]
        //[Pushbots openURL:userInfo];
        //Capture notification data e.g. badge, alert and sound
        NSDictionary *aps = [userInfo objectForKey:@"aps"];
        
        if (aps) {
            NSString *alertMsg = [aps objectForKey:@"alert"];
            NSLog(@"Notification message: %@", alertMsg);
        }
        
        //Capture custom fields
        NSString* articleId = [userInfo objectForKey:@"articleId"];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Register the deviceToken on Pushbots
    [self.PushbotsClient registerOnPushbots:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Notification Registration Error %@", [error description]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //Check for openURL [optional]
    //[Pushbots openURL:userInfo];
    //Track notification only if the application opened from Background by clicking on the notification.
    if (application.applicationState == UIApplicationStateInactive) {
        [self.PushbotsClient trackPushNotificationOpenedWithPayload:userInfo];
    }
    
    //The application was already active when the user got the notification, just show an alert.
    //That should *not* be considered open from Push.
    if (application.applicationState == UIApplicationStateActive) {
        NSDictionary *notificationDict = [userInfo objectForKey:@"aps"];
        NSString *alertString = [notificationDict objectForKey:@"alert"];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Push Notification Received" message:alertString delegate:self
                              cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo  fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    // .. Process notification data
    handler(UIBackgroundFetchResultNewData);
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
    [[Amplitude instance] initializeApiKey:@"2e5f3977f9bc996bb2cc8e451c65af1b"];
    
    [[Amplitude instance] logEvent:@"EVENT_IDENTIFIER_HERE"];
    
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
                                                          initWithRegionType:AWSRegionUSEast1
                                                          identityPoolId:@"us-east-1:2ae1ef8e-a34b-4982-a3b0-3d11b5481819"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
