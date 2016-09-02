//
//  UserLocation.m
//  Stream Savvy
//
//  Created by Allen White on 5/29/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import "UserLocation.h"
#import "AFAPIClient.h"
@interface UserLocation()<CLLocationManagerDelegate>

@property int status;

@end


@implementation UserLocation


+ (UserLocation *)sharedController
{
	static UserLocation *sharedController = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSLog(@"USER LOCATION INITIATED");
		sharedController = [[self alloc]init];
	});
	return sharedController;
}

- (id)init
{
	self = [super init];
	NSLog(@"HE SHOOTS");
	if (self) {
		NSLog(@"ALLOC INIT");
		_locationManager = [[CLLocationManager alloc]init];
		_locationManager.delegate = self;
		if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
			[self.locationManager requestWhenInUseAuthorization];
		}
		_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		_locationManager.distanceFilter = kCLLocationAccuracyBest; // or number in Meters.
		[self.locationManager startUpdatingLocation];

	}
	NSLog(@"SWOOSH");
	return self;
}



+ (void)getLocationFromIP:(void (^)(NSURLSessionDataTask *task, id JSON))successBlock{
	NSString *url = @"http://freegeoip.net/json/";
	
	[[AFAPIClient sharedClient:nil] GET:url parameters:nil
				    success:^(NSURLSessionDataTask *task, id JSON) {
					    dispatch_async( dispatch_get_main_queue(), ^{
						    successBlock(task, JSON);
					    });
				    } failure:^(NSURLSessionDataTask *task, NSError *error) {
					    dispatch_async( dispatch_get_main_queue(), ^{
						    NSLog(@"%@", url);
						    NSLog(@"~~~>%@", error);
					    });
				    }];
	/*
		{	
			"ip":			"108.208.74.155",
			"country_code":	"US",
			"country_name":	"United States",
			"region_code":	"OH",
			"region_name":	"Ohio",
			"city":			"New Albany",
			"zip_code":		"43054",
			"time_zone":		"America/New_York",
			"latitude":		40.0848,
			"longitude":		-82.8126,
			"metro_code":	535}
	 */
}



#pragma mark - Location Manager

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//	NSLog(@"LOCATIONS:::: %@", locations);
	[self.delegate locationControllerDidUpdateLocation:locations.lastObject];
	[self setLocation:locations.lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"ERRoR");
	// ...
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
	self.status = status;
	if (status == kCLAuthorizationStatusDenied) {
		//location denied, handle accordingly
		NSLog(@"idk why they said no...");
	}
	else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
		NSLog(@"WHEN IN USE");
		//do stuff with the location
		NSNumber *latitude = [NSNumber numberWithFloat:self.locationManager.location.coordinate.latitude];
		NSNumber *longitude = [NSNumber numberWithFloat:self.locationManager.location.coordinate.longitude];
	}
}


@end
