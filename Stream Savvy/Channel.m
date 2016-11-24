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
#import "UserLocation.h"

@implementation Channel


- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    //			NSLog(@"Channel~-~-~\n\n%@", attributes);
    self = [super init];
    if (!self) return nil;
    self.stationID					= [attributes valueForKey:@"stationId"] ;
    self.display_name			= [attributes valueForKey:@"callSign"];
    self.affiliate_display_name	= [attributes valueForKey:@"affiliateCallSign"];
    self.channel_number			= [attributes valueForKey:@"channel"];
    self.image_link				= [[attributes valueForKey:@"preferredImage"] valueForKey:@"uri"];
    
    self.now_playing				= [[Media alloc] initWithAttributes:[[attributes valueForKey:@"airings"] objectAtIndex:0]];
    
    return self;
}



+ (void)getGuideForLattitude:(float)lat Longitude:(float)lon view:(UIView *)view Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{
    NSString *url = [NSString stringWithFormat:@"https://edr-go-staging.herokuapp.com/gracenote/lineup-airings/%f/%f", lat, lon];
    //    	NSString *url = [NSString stringWithFormat:@"https://concurgrid.herokuapp.com/gracenote/lineup-airings/%f/%f", lat, lon];
    //        NSString *url = [NSString stringWithFormat:@"http://localhost:8080/gracenote/lineup-airings/%f/%f", lat, lon];
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
                                                                                                       //						    NSLog(@"%@", url);
                                                                                                       NSLog(@"~~~>%@", error);
                                                                                                       [MBProgressHUD hideHUDForView:view animated:YES];
                                                                                                   });
                                                                                                   //                        sleep(2);
                                                                                                   //                        [self getGuideForLattitude:lat Longitude:lon view:view Success:successBlock];
                                                                                                   
                                                                                               }];
    });
}


- (void)getChannelDetailsWithView:(UIView *)view Success:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{
    
    float lat = UserLocation.sharedController.locationManager.location.coordinate.latitude;
    float lon = UserLocation.sharedController.locationManager.location.coordinate.longitude;
    
    NSDictionary *coords = @{@"lat":  [[NSNumber numberWithFloat:lat] stringValue], @"long": [[NSNumber numberWithFloat:lon] stringValue]};
    
    
    NSString *url = @"http://edr-go-staging.herokuapp.com/live-streaming-service";
    //NSString *url = @"http://localhost:8080/live-streaming-service";
    NSLog(@"\n\n\n%@\n\n\n", url);
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    NSDictionary *params = @{
                             @"CallLetters":			self.display_name,
                             @"DisplayName":		self.affiliate_display_name,
                             //					@"SourceLongName":	self.source_long_name,
                             @"SourceId":			[NSString stringWithFormat:@"%@", self.stationID],
                             @"coords": coords,
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
