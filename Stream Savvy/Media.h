//
//  Media.h
//  Stream Savvy
//
//  Created by Allen White on 8/21/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Media : NSObject

@property (nonatomic) NSInteger			station_id;
@property (nonatomic) NSInteger			root_id;
@property (nonatomic) NSInteger			duration;
@property (nonatomic, strong) NSString	*start_time;
@property (nonatomic, strong) NSString	*end_time;
@property (nonatomic, strong) NSString	*title;
@property (nonatomic, strong) NSString	*show_description;
@property (nonatomic, strong) NSArray	*genres;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
