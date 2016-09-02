//
//  LoginViewController.m
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "LoginViewController.h"
#import "UserLocation.h"
#import "PopularShowTableViewController.h"
#import "Constants.h"
#import "User.h"
#import "UserPrefs.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.facebookButton.delegate = self;
	self.facebookButton.readPermissions = @[@"email",];
	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	if ([FBSDKAccessToken currentAccessToken] || [UserPrefs getDidLogin]) {
		// User is logged in, do work such as go to next view controller.
		[self goToNextScreen];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}

-(void)goToNextScreen{
	UITabBarController *uitbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
	[self presentViewController:uitbc animated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
}

- (IBAction)signinButtonTapped:(id)sender {
	if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0 && [self.emailTextField.text containsString:@"@"]) {
		[UserPrefs setEmail:self.emailTextField.text];
		[User loginWithPassword:self.passwordTextField.text success:^{
			[UserPrefs setDidLogin:YES];
			[self goToNextScreen];
		}];
	}else{
		[Constants showAlert:@"Whoops!" withMessage:@"We need both an email and password to continue" fromController:self];
	}
}

- (IBAction)facebookButtonTapped:(id)sender {
	[self.facebookButton setEnabled:NO];
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
	[self.facebookButton setEnabled:YES];
	if ([FBSDKAccessToken currentAccessToken]) {
		self.facebookButton.hidden = YES;
		[[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender"}]
		 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
			 if (!error) {
				 NSLog(@"fetched user:%@", result);
				 [UserPrefs setEmail:[(NSDictionary *)result objectForKey:@"email"]];
				 [User loginWithPassword:@"" success:^{
					 [UserPrefs setDidLogin:YES];
					 [self goToNextScreen];
				 }];
			 }
		 }];
	}
	
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
	
}


@end
