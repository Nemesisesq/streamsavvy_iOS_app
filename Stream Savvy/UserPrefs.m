//
//  UserPrefs.m
//  Stream Savvy
//
//  Created by Allen White on 5/28/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import "UserPrefs.h"

@implementation UserPrefs


static NSString * const user_idDefaultString		= @"user_idDefaultString";
static NSString * const usernameDefaultString	= @"usernameDefaultString";
static NSString * const firstnameDefaultString	= @"firstnameDefaultString";
static NSString * const lastnameDefaultString	= @"lastnameDefaultString";
static NSString * const bioDefaultString			= @"bioDefaultString";
static NSString * const phoneDefaultString		= @"phoneDefaultString";
static NSString * const tokenDefaultString		= @"tokenDefaultString";
static NSString * const photoLinkDefaultString	= @"photoLinkDefaultString";
static NSString * const devicePushDefaultString	= @"devicePushDefaultString";



+ (void)setUserID:(NSString *)user_id{
	NSLog(@"setUserID~~~~~~%@", user_id);
	[[NSUserDefaults standardUserDefaults] setObject:user_id forKey:user_idDefaultString];
}


+ (void)setUsername:(NSString *)username{
	[[NSUserDefaults standardUserDefaults] setObject:username forKey:usernameDefaultString];
}


+ (void)setFirstname:(NSString *)firstname{
	[[NSUserDefaults standardUserDefaults] setObject:firstname forKey:firstnameDefaultString];
}


+ (void)setLastname:(NSString *)lastname{
	[[NSUserDefaults standardUserDefaults] setObject:lastname forKey:lastnameDefaultString];
}

+ (void)setBio:(NSString *)bio{
	[[NSUserDefaults standardUserDefaults] setObject:bio forKey:bioDefaultString];
}


+ (void)setPhone:(NSString *)phone{
	[[NSUserDefaults standardUserDefaults] setObject:phone forKey:phoneDefaultString];
}


+ (void)setToken:(NSString *)token{
	[[NSUserDefaults standardUserDefaults] setObject:token forKey:tokenDefaultString];
}

+ (void)setPhoto:(NSString *)photoLink{
	[[NSUserDefaults standardUserDefaults] setObject:photoLink forKey:photoLinkDefaultString];
}

+ (void)setDevicePushToken:(NSString *)token{
	[[NSUserDefaults standardUserDefaults] setObject:token forKey:devicePushDefaultString];
}

/////////////////////////////////////////// get ///////////////////////////////////////////

+ (NSString *)getUserID{
	NSLog(@"getUserID ~%@", [[NSUserDefaults standardUserDefaults] objectForKey:user_idDefaultString]);
	NSLog(@"getUserID resutl ~%@", [[NSUserDefaults standardUserDefaults] objectForKey:user_idDefaultString] ?: @"");
	return [[NSUserDefaults standardUserDefaults] objectForKey:user_idDefaultString] ?: @"";
}


+ (NSString *)getUsername{
	return [[NSUserDefaults standardUserDefaults] objectForKey:usernameDefaultString] ?: @"";
}


+ (NSString *)getFirstname{
	return [[NSUserDefaults standardUserDefaults] objectForKey:firstnameDefaultString] ?: @"";
}


+ (NSString *)getLastname{
	return [[NSUserDefaults standardUserDefaults] objectForKey:lastnameDefaultString] ?: @"";
}


+ (NSString *)getBio{
	return [[NSUserDefaults standardUserDefaults] objectForKey:bioDefaultString] ?: @"";
}


+ (NSString *)getPhone{
	return [[NSUserDefaults standardUserDefaults] objectForKey:phoneDefaultString] ?: @"";
}


+ (NSString *)getToken{
	return [[NSUserDefaults standardUserDefaults] objectForKey:tokenDefaultString] ?: @"";
}


+ (NSString *)getPhoto{
	return [[NSUserDefaults standardUserDefaults] objectForKey:photoLinkDefaultString] ?: @"";
}

+ (NSString *)getDevicePushToken{
	return [[NSUserDefaults standardUserDefaults] objectForKey:devicePushDefaultString] ?: @"";
}

@end
