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
    
    NSDictionary *program = [attributes valueForKey:@"program"];
    
	//		NSLog(@"User~-~-~\n\n%@", attributes);
	self = [super init];
	if (!self) return nil;
	self.station_id			= [[attributes valueForKey:@"stationId"] integerValue];
	self.root_id				= [[program valueForKey:@"rootId"] integerValue];
	self.duration				= [[attributes valueForKey:@"duration"] integerValue];
	self.start_time			= [Constants formalTimeWithTimeZone: [attributes valueForKey:@"startTime"]];
	self.end_time			= [Constants formalTimeWithTimeZone: [attributes valueForKey:@"endTime"]];
	self.title					= [program valueForKey:@"title"];
    self.episodeTitle = [program valueForKey:@"episodeTitle"];
	self.show_description		= [program valueForKey:@"shortDescription"];
	self.genres				= [program objectForKey:@"genres"];
        self.preferredImage = [program objectForKey:@"preferredImage"];
//	self.deep_link			= [Media randomUrl];
	NSLog(@"genres: %@", self.genres);
	
	return self;
}

@end
