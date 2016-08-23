//
//  User.m
//  Leap
//
//  Created by Allen White on 7/4/16.
//  Copyright © 2016 Leap Innovations. All rights reserved.
//

#import "User.h"
#import "AFAPIClient.h"
#import "UserPrefs.h"
#import "Constants.h"

@implementation User


- (instancetype)initWithAttributes:(NSDictionary *)attributes{
	//		NSLog(@"User~-~-~\n\n%@", attributes);
	self = [super init];
	if (!self) return nil;
	self.user_id				= [[attributes valueForKeyPath:@"id"] integerValue];
	self.email				= [attributes valueForKey:@"email"];
	self.firstname			= [attributes valueForKey:@"firstname"];
	self.lastname			= [attributes valueForKey:@"lastname"];
	
	return self;
}



+ (void)loginWithPassword:(NSString *)password success:(void (^)(void))successBlock{
	NSString *url = @"http://ss-master-staging.herokuapp.com/sign_up/";
	NSDictionary *params = @{
							@"email"			:[UserPrefs getEmail],
							@"password"		:password,
							@"username"		:[UserPrefs getEmail]
						 };
	[[AFAPIClient sharedClient:nil] POST:url parameters:params
				     success:^(NSURLSessionDataTask *task, id json) {
						NSLog(@"1 - %@", ((NSDictionary *)json));
						[UserPrefs setFirstname:	[((NSDictionary *)json) objectForKey:@"firstname"]];
						[UserPrefs setLastname:	[((NSDictionary *)json) objectForKey:@"lastname"]];
						[UserPrefs setEmail:		[((NSDictionary *)json) objectForKey:@"email"]];
						successBlock();

				     } failure:^(NSURLSessionDataTask *task, NSError *error) {
					     NSLog(@"~~~>%@", error);
				     }];
}

@end
