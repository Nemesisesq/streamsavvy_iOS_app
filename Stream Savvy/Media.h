//
//  Media.h
//  Stream Savvy
//
//  Created by Allen White on 8/21/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Media : NSObject

@property (nonatomic) NSInteger			program_id;
@property (strong, nonatomic) NSString	*title;
@property (strong, nonatomic) NSString	*image_link;
@property (strong, nonatomic) NSString	*time;
@property (strong, nonatomic) NSString	*deep_link;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;


@end
