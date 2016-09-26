//
//  AuthTableViewController.m
//  Stream Savvy
//
//  Created by Allen White on 9/9/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "AuthTableViewController.h"
#import "Constants.h"
#import "UserPrefs.h"
#import "LoginViewController.h"

@interface AuthTableViewController ()

@end

@implementation AuthTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	if ([FBSDKAccessToken currentAccessToken] || ([UserPrefs getDidLogin] && [UserPrefs getToken].length > 0) ) {
		NSLog(@"WOOOOOOO");
	}else{
		NSLog(@"Awwww");
		LoginViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
		[self presentViewController:lvc animated:YES completion:nil];
	}
}

@end
