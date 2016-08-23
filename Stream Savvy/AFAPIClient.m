//
//  AFAPIClient.m
//  Stream Savvy
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import "AFAPIClient.h"
#import "Constants.h"

static NSString * const AFAPIBaseURLString = @"";

@implementation AFAPIClient

NSString *auth;

//singleton using gcd
+ (instancetype)sharedClient:(NSString *)authID{
	auth = authID;
	static AFAPIClient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:_sharedClient.responseSerializer.acceptableContentTypes];
		[contentTypes addObject:@"application/vnd.api+json"];
		[contentTypes addObject:@"application/json"];
		[contentTypes addObject:@"text/html"];
		
		_sharedClient = [[AFAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAPIBaseURLString]];
		_sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
		_sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
		_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
		_sharedClient.responseSerializer.acceptableContentTypes = contentTypes;
	});
	return _sharedClient;
}

/* HEADER AUTH */

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler
{
	NSMutableURLRequest *req = (NSMutableURLRequest *)request;
	if (auth) {
		[req setValue:auth forHTTPHeaderField:@"Authorization"];
	}
	return [super dataTaskWithRequest:req completionHandler:completionHandler];
}


+(BOOL)requestSuccess:(NSDictionary *)json{
	if (![[json objectForKey:@"success"] boolValue]) {
		[Constants showAlert:@"Avast!" withMessage:[((NSDictionary *)json) objectForKey:@"error"]];
		return NO;
	}
	return YES;
}

@end
