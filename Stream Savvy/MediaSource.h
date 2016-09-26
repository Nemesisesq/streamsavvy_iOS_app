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
@property (strong, nonatomic) NSArray	*deep_links;
@property (strong, nonatomic) NSString  *app_store_link;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (NSString *)randomNetflixUrl;
+ (NSString *)randomYoutubeUrl;

	
@end
