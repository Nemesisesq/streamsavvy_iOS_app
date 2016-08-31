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
@property (strong, nonatomic) NSString	*image_link;
@property (strong, nonatomic) NSString	*source;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
