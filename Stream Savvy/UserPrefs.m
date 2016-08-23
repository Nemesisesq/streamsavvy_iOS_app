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
static NSString * const firstnameDefaultString	= @"firstnameDefaultString";
static NSString * const lastnameDefaultString	= @"lastnameDefaultString";
static NSString * const emailDefaultString		= @"emailDefaultString";
static NSString * const tokenDefaultString		= @"tokenDefaultString";
static NSString * const didLoginDefaultString	= @"didLoginDefaultString";


+ (void)setUserID:(NSString *)user_id{
	[[NSUserDefaults standardUserDefaults] setObject:user_id forKey:user_idDefaultString];
}


+ (void)setFirstname:(NSString *)firstname{
	[[NSUserDefaults standardUserDefaults] setObject:firstname forKey:firstnameDefaultString];
}


+ (void)setLastname:(NSString *)lastname{
	[[NSUserDefaults standardUserDefaults] setObject:lastname forKey:lastnameDefaultString];
}


+ (void)setEmail:(NSString *)email{
	[[NSUserDefaults standardUserDefaults] setObject:email forKey:emailDefaultString];
}


+ (void)setToken:(NSString *)token{
	[[NSUserDefaults standardUserDefaults] setObject:token forKey:tokenDefaultString];
}


+ (void)setDidLogin:(BOOL)didLogin{
	[[NSUserDefaults standardUserDefaults] setBool:didLogin forKey:didLoginDefaultString];
}


/////////////////////////////////////////// get ///////////////////////////////////////////

+ (NSString *)getUserID{
	return [[NSUserDefaults standardUserDefaults] objectForKey:user_idDefaultString] ?: @"";
}


+ (NSString *)getFirstname{
	return [[NSUserDefaults standardUserDefaults] objectForKey:firstnameDefaultString] ?: @"";
}


+ (NSString *)getLastname{
	return [[NSUserDefaults standardUserDefaults] objectForKey:lastnameDefaultString] ?: @"";
}


+ (NSString *)getEmail{
	return [[NSUserDefaults standardUserDefaults] objectForKey:emailDefaultString] ?: @"";
}


+ (NSString *)getToken{
	return [[NSUserDefaults standardUserDefaults] objectForKey:tokenDefaultString] ?: @"";
}


+ (BOOL)getDidLogin{
	return [[NSUserDefaults standardUserDefaults] objectForKey:didLoginDefaultString] ?: NO;
}

@end
