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


+ (NSString *)randomNetflixUrl{
	NSArray *links = @[
			   @"http://movies.netflix.com/Movie/80078152",
			   @"http://movies.netflix.com/Movie/80028571",
			   @"http://movies.netflix.com/Movie/80010542",
			   @"http://movies.netflix.com/Movie/80073821",
			   @"http://movies.netflix.com/Movie/80045624",
			   @"http://movies.netflix.com/Movie/80102238"
			   ];
	NSUInteger randomIndex = arc4random() % [links count];
	return [links objectAtIndex:randomIndex];
}


+ (NSString *)randomYoutubeUrl{
	NSArray *links = @[
			   @"https://www.youtube.com/watch?v=u9YUMs6h2hc",
			   @"https://www.youtube.com/watch?v=WVMZEJ_u2z0",
			   @"https://youtu.be/cV4kf-3y4Fc?t=11m25s",
			   @"https://youtu.be/LUYMhoOJhH0?t=25m56s",
			   @"https://www.youtube.com/watch?v=infDoObjcjE",
			   @"https://youtu.be/4bUxoUVKmb4?t=2m55s"
			   ];
	NSUInteger randomIndex = arc4random() % [links count];
	return [links objectAtIndex:randomIndex];
}


@end
