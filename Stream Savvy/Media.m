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


@end
