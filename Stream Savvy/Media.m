//
//  Media.m
//  Stream Savvy
//
//  Created by Allen White on 8/21/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "Media.h"
#import "AFAPIClient.h"

@implementation Media



- (instancetype)initWithAttributes:(NSDictionary *)attributes{
	//		NSLog(@"User~-~-~\n\n%@", attributes);
	self = [super init];
	if (!self) return nil;
	self.program_id			= [[attributes valueForKey:@"ProgramId"] integerValue];
	self.title					= [attributes valueForKey:@"Title"];
	self.image_link			= [attributes valueForKey:@"artwork_608x342"];
	self.deep_link			= @""; // ???????
	
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
