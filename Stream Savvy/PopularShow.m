//
//  PopularShow.m
//  Stream Savvy
//
//  Created by Allen White on 8/22/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "PopularShow.h"
#import "AFAPIClient.h"
#import "Constants.h"
#import "MBProgressHUD.h"

@implementation PopularShow


- (instancetype)initWithAttributes:(NSDictionary *)attributes{
	self = [super init];
	NSLog(@"\t\tattributts: %@", attributes);
	NSLog(@"~~~~~~~~~~~~~~");
	if (!self) return nil;
	self.guidebox_id			= [[[attributes valueForKey:@"guidebox_data"] valueForKey:@"id"] integerValue];
	self.title					= [attributes valueForKey:@"title"];
	self.image_link			= [[attributes valueForKey:@"guidebox_data"] valueForKey:@"artwork_608x342"];
	NSLog(@"^^\t%@", self.image_link);
	self.time					= [[[attributes valueForKey:@"guidebox_data"] valueForKey:@"detail"] valueForKey:@"air_time"]; // air_day_of_week
	self.duration				= [[[[attributes valueForKey:@"guidebox_data"] valueForKey:@"detail"] valueForKey:@"runtime"] integerValue];
//	self.deep_link			= [PopularShow randomUrl];
	self.raw					= attributes;
	NSMutableArray *genres = [NSMutableArray new];
	for (NSDictionary *genre in [[[attributes valueForKey:@"guidebox_data"] valueForKey:@"detail"] valueForKey:@"genres"]) {
		[genres addObject:[genre valueForKey:@"title"]];
	}
	self.genres = genres;
	
	return self;
}



//////// gonna save this for now, we will put it somewhere eventually
+ (void)getPopularShowsForPage:(NSInteger)page view:(UIView *)view Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{
	NSString *url = @"https://ss-master-staging.herokuapp.com/api/popular-shows/";
	if (page)
		url = [NSString stringWithFormat:@"%@page%ld", url, (long)page];
	NSLog(@"%@\n\n\n", url);
	[MBProgressHUD showHUDAddedTo:view animated:YES];
	dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		[[AFAPIClient sharedClient:nil] GET:url parameters:nil
				    success:^(NSURLSessionDataTask *task, id JSON) {
					    dispatch_async( dispatch_get_main_queue(), ^{
						    successBlock(task, JSON);
						    [MBProgressHUD hideHUDForView:view animated:YES];
					    });
				    } failure:^(NSURLSessionDataTask *task, NSError *error) {
					    dispatch_async( dispatch_get_main_queue(), ^{
						    NSLog(@"%@", url);
						    NSLog(@"~~~>%@", error);
						    [MBProgressHUD hideHUDForView:view animated:YES];
					    });
				    }];
	});
}

- (void)getShowDetailsWithView:(UIView *)view Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{
	NSString *url = @"http://edr-go-staging.herokuapp.com/on-demand-streaming-service";

	NSLog(@"%@\n\n\n", url);
	[MBProgressHUD showHUDAddedTo:view animated:YES];
	dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		[[AFAPIClient sharedClient:nil] POST:url parameters:self.raw
					    success:^(NSURLSessionDataTask *task, id JSON) {
						    dispatch_async( dispatch_get_main_queue(), ^{
							    successBlock(task, JSON);
							    [MBProgressHUD hideHUDForView:view animated:YES];
						    });
					    } failure:^(NSURLSessionDataTask *task, NSError *error) {
						    dispatch_async( dispatch_get_main_queue(), ^{
							    NSLog(@"%@", url);
							    NSLog(@"~~~>%@", error);
							    [MBProgressHUD hideHUDForView:view animated:YES];
						    });
					    }];
	});
}
@end
