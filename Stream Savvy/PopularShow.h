//
//  PopularShow.h
//  Stream Savvy
//
//  Created by Allen White on 8/22/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopularShow : NSObject

@property (nonatomic) NSInteger			guidebox_id;
@property (strong, nonatomic) NSString	*title;
@property (strong, nonatomic) NSString	*image_link;
@property (strong, nonatomic) NSString	*deep_link;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getPopularShowsForPage:(NSInteger)page Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock;

@end
