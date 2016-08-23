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
@property (strong, nonatomic) NSString	*firstname;
@property (strong, nonatomic) NSString	*lastname;


// these are methods related to the user object
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)loginWithPassword:(NSString *)password success:(void (^)(void))successBlock;


@end
