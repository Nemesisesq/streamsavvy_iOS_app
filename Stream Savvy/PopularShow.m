//
//  PopularShow.m
//  Stream Savvy
//
//  Created by Allen White on 8/22/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "PopularShow.h"
#import "AFAPIClient.h"

@implementation PopularShow


- (instancetype)initWithAttributes:(NSDictionary *)attributes{
	//		NSLog(@"User~-~-~\n\n%@", attributes);
	self = [super init];
	if (!self) return nil;
	self.guidebox_id			= [[[attributes valueForKey:@"guidebox_data"] valueForKey:@"id"] integerValue];
	self.title					= [attributes valueForKey:@"title"];
	self.image_link			= [[attributes valueForKey:@"guidebox_data"] valueForKey:@"artwork_608x342"];
	self.deep_link			= @"link-goes-here";
	
	return self;
}



//////// gonna save this for now, we will put it somewhere eventually
+ (void)getPopularShowsForPage:(NSInteger)page Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{
	NSString *url = @"https://ss-master-staging.herokuapp.com/api/popular-shows?";
	if (page)
		url = [NSString stringWithFormat:@"%@page%ld", url, (long)page];
	
	[[AFAPIClient sharedClient:nil] GET:url parameters:nil
				    success:^(NSURLSessionDataTask *task, id JSON) {
					    dispatch_async( dispatch_get_main_queue(), ^{
						    successBlock(task, JSON);
					    });
				    } failure:^(NSURLSessionDataTask *task, NSError *error) {
					    dispatch_async( dispatch_get_main_queue(), ^{
						    NSLog(@"%@", url);
						    NSLog(@"~~~>%@", error);
					    });
				    }];
}



@end
