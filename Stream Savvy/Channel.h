//
//  Channel.h
//  Stream Savvy
//
//  Created by Allen White on 8/22/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"

@interface Channel : NSObject

@property (nonatomic) NSNumber			*channel_id;
@property (strong, nonatomic) NSString	*display_name;
@property (strong, nonatomic) NSString	*image_link;
@property (strong, nonatomic) NSString	*deep_link;
@property (strong, nonatomic) Media		*now_playing;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getRoviGuideForZipcode:(NSInteger)zipcode Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock;

@end
