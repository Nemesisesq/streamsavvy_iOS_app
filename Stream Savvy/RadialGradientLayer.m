//
//  RadialGradientLayer.m
//  Stream Savvy
//
//  Created by Allen White on 10/31/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "RadialGradientLayer.h"

@implementation RadialGradientLayer

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setNeedsDisplay];
	}
	return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
	size_t gradLocationsNum = 2;
	CGFloat gradLocations[2] = {0.0f, 1.0f};
	CGFloat gradColors[8] = {0.0f,0.0f,0.0f,1.0f,0.0f,0.0f,0.0f,0.0f};
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
	CGColorSpaceRelease(colorSpace);
	
	CGPoint gradCenter= CGPointMake(0, self.bounds.size.height);
	float gradRadius = self.bounds.size.width;
	
	CGContextDrawRadialGradient (ctx, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
}


@end
