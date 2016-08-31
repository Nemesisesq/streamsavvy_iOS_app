//
//  MediaSource.m
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "MediaSource.h"

@implementation MediaSource


- (instancetype)initWithAttributes:(NSDictionary *)attributes{
	//		NSLog(@"User~-~-~\n\n%@", attributes);
	self = [super init];
	if (!self) return nil;
	self.display_name			= [attributes valueForKey:@"display_name"];
	self.source					= [attributes valueForKey:@"source"];
	NSLog(@"attributes:\t%@",attributes);
	return self;
}


@end
