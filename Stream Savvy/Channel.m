//
//  Channel.m
//  Stream Savvy
//
//  Created by Allen White on 8/22/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "Channel.h"
#import "AFAPIClient.h"

@implementation Channel

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
	//		NSLog(@"User~-~-~\n\n%@", attributes);
	self = [super init];
	if (!self) return nil;
	self.channel				= [attributes valueForKey:@"Channel"] ;
	self.display_name		= [attributes valueForKey:@"DisplayName"];
	self.image_link			= [[[attributes valueForKey:@"ChannelImages"] objectAtIndex:0] valueForKey:@"ImageUrl"];
	self.deep_link			= @"link-goes-here";
	self.now_playing			= [[Media alloc] initWithAttributes:[[attributes valueForKey:@"Airings"] objectAtIndex:0]];
	
	return self;
}



+ (void)getRoviGuideForZipcode:(NSInteger)zipcode Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{
	NSString *url = [NSString stringWithFormat:@"https://ss-master-staging.herokuapp.com/api/guide/%ld", (long)zipcode];
	
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
