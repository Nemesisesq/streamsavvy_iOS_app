//
//  Channel.m
//  Stream Savvy
//
//  Created by Allen White on 8/22/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "Channel.h"
#import "AFAPIClient.h"
#import "MBProgressHUD.h"
#import "UserPrefs.h"

@implementation Channel

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
//			NSLog(@"Channel~-~-~\n\n%@", attributes);
	self = [super init];
	if (!self) return nil;
	self.channel_id				= [attributes valueForKey:@"Channel"] ;
	self.display_name			= [attributes valueForKey:@"DisplayName"];
	if ([[[[attributes valueForKey:@"Airings"] objectAtIndex:0]  valueForKey:@"images"] count] > 0) {
		self.image_link			= [[[[[attributes valueForKey:@"Airings"] objectAtIndex:0] valueForKey:@"images"] objectAtIndex:0] valueForKey: @"ImageUrl"];
	}else if([[[attributes valueForKey:@"ChannelImages"] objectAtIndex:0] count] > 0){
		self.image_link			= [[[attributes valueForKey:@"ChannelImages"] objectAtIndex:0] valueForKey:@"ImageUrl"];
	} else {
		self.image_link = @"";
	}
	self.channel_number			= [attributes valueForKey:@"Channel"];
	self.deep_link				= @"link-goes-here";
	self.source_id				= [attributes valueForKey:@"SourceId"];
	self.source_long_name		= [attributes valueForKey:@"SourceLongName"];
	self.call_letters				= [attributes valueForKey:@"CallLetters"];
	
	self.now_playing				= [[Media alloc] initWithAttributes:[[attributes valueForKey:@"Airings"] objectAtIndex:0]];
	
	return self;
}



+ (void)getRoviGuideForLattitude:(float)lat Longitude:(float)lon view:(UIView *)view Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{
	NSString *url = [NSString stringWithFormat:@"https://ss-master-staging.herokuapp.com/api/guide/%f/%f", lat, lon];
	NSLog(@"%@\n\n\n", url);
	[MBProgressHUD showHUDAddedTo:view animated:YES];
	dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
	[[AFAPIClient sharedClient:[NSString stringWithFormat:@"Bearer_%@", [UserPrefs getToken]]] GET:url parameters:nil
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


- (void)getChannelDetailsWithView:(UIView *)view Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{

	NSString *url = @"https://edr-go-staging.herokuapp.com/live-streaming-service";

	
	NSLog(@"\n\n\n%@\n\n\n", url);
	[MBProgressHUD showHUDAddedTo:view animated:YES];
	NSDictionary *params = @{
					@"CallLetters":			self.call_letters,
					@"DisplayName":		self.display_name,
					@"SourceLongName":	self.source_long_name,
					@"SourceId":			[NSString stringWithFormat:@"%@", self.source_id]
				 };
	NSLog(@"\n\n\n%@\n\n\n", params);
	dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		[[AFAPIClient sharedClient:nil] POST:url parameters:params
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
