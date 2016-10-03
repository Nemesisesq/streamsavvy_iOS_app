//
//  Media.m
//  Stream Savvy
//
//  Created by Allen White on 8/21/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "Media.h"
#import "AFAPIClient.h"
#import "Constants.h"

@implementation Media


- (instancetype)initWithAttributes:(NSDictionary *)attributes{
	//		NSLog(@"User~-~-~\n\n%@", attributes);
	self = [super init];
	if (!self) return nil;
	self.station_id			= [[attributes valueForKey:@"stationId"] integerValue];
	self.root_id				= [[[attributes valueForKey:@"program"] valueForKey:@"rootId"] integerValue];
	self.duration				= [[attributes valueForKey:@"duration"] integerValue];
	self.start_time			= [Constants formalTimeWithTimeZone: [attributes valueForKey:@"startTime"]];
	self.end_time			= [Constants formalTimeWithTimeZone: [attributes valueForKey:@"endTime"]];
	self.title					= [[attributes valueForKey:@"program"] valueForKey:@"title"];
	self.show_description		= [[attributes valueForKey:@"program"] valueForKey:@"shortDescription"];
	self.genres				= [[attributes valueForKey:@"program"] objectForKey:@"genres"];
//	self.deep_link			= [Media randomUrl];
	NSLog(@"genres: %@", self.genres);
	
	return self;
}

@end
