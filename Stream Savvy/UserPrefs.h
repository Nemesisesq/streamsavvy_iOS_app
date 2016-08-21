//
//  UserPrefs.h
//  Stream Savvy
//
//  Created by Allen White on 5/28/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPrefs : NSObject

/*
	we will definitely need 
		some login verification stuff, 
	maybe 
		a user id, 
		location stuff, but not sure what else
 */
+ (void)setUserID:(NSString *)user_id;
+ (void)setUsername:(NSString *)username;
+ (void)setFirstname:(NSString *)firstname;
+ (void)setLastname:(NSString *)lastname;
+ (void)setBio:(NSString *)bio;
+ (void)setPhone:(NSString *)phone;
+ (void)setPhoto:(NSString *)photoLink;
+ (void)setToken:(NSString *)token;
+ (void)setDevicePushToken:(NSString *)token;

+ (NSString *)getUserID;
+ (NSString *)getUsername;
+ (NSString *)getFirstname;
+ (NSString *)getLastname;
+ (NSString *)getBio;
+ (NSString *)getPhone;
+ (NSString *)getPhoto;
+ (NSString *)getToken;
+ (NSString *)getDevicePushToken;

@end
