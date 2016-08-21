//
//  User.h
//  Leap
//
//  Created by Allen White on 7/4/16.
//  Copyright © 2016 Leap Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSInteger			user_id;
@property (strong, nonatomic) NSString	*email;
@property (strong, nonatomic) NSString	*phone;
@property (strong, nonatomic) NSString	*firstname;
@property (strong, nonatomic) NSString	*lastname;
@property (strong, nonatomic) NSString	*bio;
@property (strong, nonatomic) NSString	*gender;
@property (strong, nonatomic) NSString	*profile_pic;
@property (strong, nonatomic) NSDate		*signUp;
@property (nonatomic) Boolean			verified;
@property (nonatomic) Boolean			active;
@property (nonatomic) NSInteger			num_rides;
@property (nonatomic) NSArray			*destination_cities;

// these are methods related to the user object
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)createWithPassword:(NSString *)password success:(void (^)(void))successBlock;

+ (void)updateSelf:(void (^)(void))successBlock;

+ (void)getUserByID:(NSInteger)user_id success:(void (^)(User *))successBlock;

+ (void)loginWithPassword:(NSString *)password success:(void (^)(void))successBlock;

+ (void)verifyWithCode:(NSString *)code success:(void (^)(void))successBlock;

+ (void)resetPassword:(NSString *)email;

@end
