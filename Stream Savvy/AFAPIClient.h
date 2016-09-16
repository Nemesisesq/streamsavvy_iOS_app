//
//  AFAPIClient.h
//  Stream Savvy
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//
// http://stackoverflow.com/questions/32631184/the-resource-could-not-be-loaded-because-the-app-transport-security-policy-requi

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"

@interface AFAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient:(NSString *)authID;
+(BOOL)requestSuccess:(NSDictionary *)json;


@end



/* ///////////////////////////////////////////// POST ///////////////////////////////

	NSString *url = @"users";
	NSDictionary *params = @{
								@"data":@{
									@"phone":[UserPrefs getPhone]
								}
							};
dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	[[AFAPIClient sharedClient:nil] POST:url parameters:params
		success:^(NSURLSessionDataTask *task, id abc) {
			dispatch_async( dispatch_get_main_queue(), ^{
				NSLog(@"success");
				NSString *authID = [[[((NSDictionary *)abc) objectForKey:@"data"] objectForKey:@"attributes"] objectForKey:@"id"];
			});
		} failure:^(NSURLSessionDataTask *task, NSError *error) {
			NSLog(@"~~~>%@", error);
		}];
	});

*/




/*  ///////////////////////////////////////////// GET ///////////////////////////////
NSString *url = @"/users";
NSString *token = [UserPrefs getToken];
NSDictionary *params = @{
	@"data":@{
		@"phone":[UserPrefs getPhone]
	}
 };
dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	[[AFAPIClient sharedClient:token] GET:url parameters: params success:^(NSURLSessionDataTask *task, id JSON) {
		dispatch_async( dispatch_get_main_queue(), ^{
			// Add code here to update the UI/send notifications based on the
			// results of the background processing
			NSMutableArray *eventz = [NSMutableArray new];
			for (NSDictionary *event in [((NSDictionary *)JSON) objectForKey:@"data"]) {
				NSLog(@"&&&&&& \n\n%@\n\n", [event objectForKey:@"attributes"]);
			}
		});
 
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		dispatch_async( dispatch_get_main_queue(), ^{
			NSLog(@"%@", url);
			NSLog(@"~~~>%@", error);
		});
	}];
});
*/
