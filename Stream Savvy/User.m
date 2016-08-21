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
	self.phone				= [attributes valueForKey:@"phone"];
	self.firstname			= [attributes valueForKey:@"firstname"];
	self.lastname			= [attributes valueForKey:@"lastname"];
	self.bio					= [attributes valueForKey:@"bio"];
	self.profile_pic			= [attributes valueForKey:@"profile_pic"];
	self.signUp				= [attributes valueForKey:@"signUp"];
	self.verified				= [[attributes valueForKeyPath:@"verified"] boolValue];
	self.active				= [[attributes valueForKeyPath:@"active"] boolValue];
	self.num_rides			= [[attributes valueForKeyPath:@"num_rides"] integerValue];
	
	return self;
}





+ (void)createWithPassword:(NSString *)password success:(void (^)(void))successBlock{
	NSString *url = @"users";
	NSDictionary *params = @{
				 @"data":@{
						 @"firstname"		:[UserPrefs getFirstname],
						 @"lastname"		:[UserPrefs getLastname],
						 @"email"			:[UserPrefs getEmail],
						 @"apnsToken"		:[UserPrefs getDevicePushToken],
						 @"password"		:[Constants trim:password]
						 }
				 };
	[[AFAPIClient sharedClient:nil] POST:url parameters:params
		success:^(NSURLSessionDataTask *task, id json) {
			if ([AFAPIClient requestSuccess:(NSDictionary *)json]) {
				NSLog(@"1 - %@", ((NSDictionary *)json));
				NSString *user_id = [[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"id"];
				[UserPrefs setUserID:user_id];
				[Constants AWLog:user_id LINE:__LINE__ FUNCTION:__FUNCTION__];
				[Constants AWLog:[UserPrefs getUserID] LINE:__LINE__ FUNCTION:__FUNCTION__];
				successBlock();
			}
		} failure:^(NSURLSessionDataTask *task, NSError *error) {
			NSLog(@"~~~>%@", error);
		}];
}


+ (void)updateSelf:(void (^)(void))successBlock{
	NSString *url = [NSString stringWithFormat:@"users/%@", [UserPrefs getUserID]];
	NSLog(@"updateSelf url: %@", url);
	NSDictionary *params = @{
				 @"data":@{
						 @"firstname"		:[UserPrefs getFirstname],
						 @"lastname"		:[UserPrefs getLastname],
						 @"email"			:[UserPrefs getEmail],
						 @"phone"			:[UserPrefs getPhone],
						 @"bio"				:[UserPrefs getBio],
						 @"profile_pic"		:[UserPrefs getPhoto],
						 @"apnsToken"		:[UserPrefs getDevicePushToken]
						 }
				 };
	NSLog(@"updateSelfDictionary: %@", params);
	dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[[AFAPIClient sharedClient:nil] PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id json) {
			if ([AFAPIClient requestSuccess:(NSDictionary *)json]) {
				successBlock();
			}else{
				NSLog(@"My Nigga");
			}
		} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
			NSLog(@"~~~>%@", error);
		}];
	});
}


+ (void)getUserByID:(NSInteger)user_id success:(void (^)(User *))successBlock{
	__block NSMutableDictionary *user = [NSMutableDictionary new];
	
	NSString *url = [NSString stringWithFormat:@"users/%ld", (long)user_id];
	
	[[AFAPIClient sharedClient:nil] POST:url parameters:nil
				    success:^(NSURLSessionDataTask *task, id JSON) {
					    if ([AFAPIClient requestSuccess:(NSDictionary *)JSON]) {
						    [Constants AWLog:JSON LINE:__LINE__ FUNCTION:__FUNCTION__];
						    user = (NSMutableDictionary *)[(NSDictionary *)JSON objectForKey:@"user"];
						    User *this_user = [[User alloc] initWithAttributes:user];
						    NSLog(@"%@", user);
						    
						    NSLog(@"~~ 3");
						    [UserPrefs setFirstname:this_user.firstname];
						    [UserPrefs setLastname:this_user.lastname];
						    [UserPrefs setBio:this_user.bio];
						    [UserPrefs setEmail:this_user.email];
						    //	[UserPrefs setGender:self.user.gender];
						    successBlock(this_user);
					    }
				    } failure:^(NSURLSessionDataTask *task, NSError *error) {
					    dispatch_async( dispatch_get_main_queue(), ^{
						    NSLog(@"%@", url);
						    NSLog(@"~~~>%@", error);
					    });
				    }];
}


+ (void)loginWithPassword:(NSString *)password success:(void (^)(void))successBlock{
	NSString *url = @"users";
	NSDictionary *params = @{
				 @"data":@{
						 @"email"			:[UserPrefs getEmail],
						 @"password"		:password
						 }
				 };
	[[AFAPIClient sharedClient:nil] PUT:url parameters:params
				     success:^(NSURLSessionDataTask *task, id json) {
					     if ([AFAPIClient requestSuccess:(NSDictionary *)json]) {
						     NSLog(@"1 - %@", ((NSDictionary *)json));
						     NSString *user_id = [[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"id"];
						     [UserPrefs setUserID:		user_id];
						     [UserPrefs setFirstname:	[[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"firstname"]];
						     [UserPrefs setLastname:	[[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"lastname"]];
						     [UserPrefs setBio:			[[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"bio"]];
						     [UserPrefs setEmail:		[[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"email"]];
						     NSLog(@"%@", [[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"phone"]);
						     if ([[((NSDictionary *)json) objectForKey:@"data"] valueForKey:@"phone"] != [NSNull null]){
							     [UserPrefs setPhone:	[[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"phone"]];
						     }
						     if ([[((NSDictionary *)json) objectForKey:@"data"] valueForKey:@"profile_pic"] != [NSNull null]){
							     [UserPrefs setPhoto:	[[((NSDictionary *)json) objectForKey:@"data"] objectForKey:@"profile_pic"]];
						     }
						     //	[UserPrefs setGender:self.user.gender];
					
						     [Constants AWLog:user_id LINE:__LINE__ FUNCTION:__FUNCTION__];
						     [Constants AWLog:[UserPrefs getUserID] LINE:__LINE__ FUNCTION:__FUNCTION__];
						     successBlock();
					     }
				     } failure:^(NSURLSessionDataTask *task, NSError *error) {
					     NSLog(@"~~~>%@", error);
				     }];
}


+ (void)verifyWithCode:(NSString *)code success:(void (^)(void))successBlock{
	NSString *url = [NSString stringWithFormat:@"users/%@?code=%@", [UserPrefs getUserID], code ];
	[[AFAPIClient sharedClient:nil] GET:url parameters:nil
				    success:^(NSURLSessionDataTask *task, id json) {
					    if ([AFAPIClient requestSuccess:(NSDictionary *)json]) {
						    successBlock();
					    }
				    } failure:^(NSURLSessionDataTask *task, NSError *error) {
					    NSLog(@"~~~>%@", error);
				    }];
}

+ (void)resetPassword:(NSString *)email{
	NSString *url = [NSString stringWithFormat:@"password/%@", email];
	[[AFAPIClient sharedClient:nil] GET:url parameters:nil
				    success:^(NSURLSessionDataTask *task, id json) {
					    if ([AFAPIClient requestSuccess:(NSDictionary *)json]) {
						    NSLog(@"password reset request sent");
					    }
				    } failure:^(NSURLSessionDataTask *task, NSError *error) {
					    NSLog(@"~~~>%@", error);
				    }];
}

@end
