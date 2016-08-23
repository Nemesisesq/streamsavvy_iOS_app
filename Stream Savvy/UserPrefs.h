//
//  UserPrefs.h
//  Stream Savvy
//
//  Created by Allen White on 5/28/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPrefs : NSObject


+ (void)setUserID:(NSString *)user_id;
+ (void)setFirstname:(NSString *)firstname;
+ (void)setLastname:(NSString *)lastname;
+ (void)setEmail:(NSString *)email;
+ (void)setToken:(NSString *)token;
+ (void)setDidLogin:(BOOL)didLogin;

+ (NSString *)getUserID;
+ (NSString *)getFirstname;
+ (NSString *)getLastname;
+ (NSString *)getEmail;
+ (NSString *)getToken;
+ (BOOL)getDidLogin;

@end
