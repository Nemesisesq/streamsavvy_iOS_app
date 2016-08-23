//
//  SDWebModel.m
//  Stream Savvy
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import "SDWebModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SDWebModel

+(void)loadImageFor:(UIImageView *)imageView withRemoteURL:(NSString *)url{
	if (![url isEqual:[NSNull null]]) {
		[imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed: @"default_profile_pic"]];
	}else{
		[imageView setImage:[UIImage imageNamed: @"default_profile_pic"]];
	}
}

@end
