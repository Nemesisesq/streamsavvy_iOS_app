//
//  UserLocation.m
//  Stream Savvy
//
//  Created by Allen White on 5/29/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import "UserLocation.h"

@implementation UserLocation


+ (UserLocation *)sharedController
{
	static UserLocation *sharedController = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedController = [[self alloc]init];
	});
	return sharedController;
}

- (id)init
{
	self = [super init];
	if (self) {
		_locationManager = [[CLLocationManager alloc]init];
		_locationManager.delegate = self;
		_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		_locationManager.distanceFilter = 30; // Meters.
	}
	return self;
}


#pragma mark - Location Manager

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	[self.delegate locationControllerDidUpdateLocation:locations.lastObject];
	[self setLocation:locations.lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	// ...
}


@end
