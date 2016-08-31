//
//  MediaSource.h
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaSource : NSObject

@property (strong, nonatomic) NSString	*display_name;
@property (strong, nonatomic) NSString	*source;
@property (strong, nonatomic) NSString	*deep_link;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (NSString *)randomNetflixUrl;
+ (NSString *)randomYoutubeUrl;

	
@end
