//
//  AppDelegate.h
//  Stream Savvy
//
//  Created by Allen White on 8/10/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Harpy/Harpy.h>
#import <Pushbots/Pushbots.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Pushbots *PushbotsClient;

@end

