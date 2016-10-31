//
//  LiveGuideTableViewCell.m
//  Stream Savvy
//
//  Created by Allen White on 10/22/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "LiveGuideTableViewCell.h"
#import "Constants.h"
#import "SDWebModel.h"

@implementation LiveGuideTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellDetails{
//	[Constants addGradientForImageView:self.backGroundImageView];
	[Constants addRadialGradientForImageView:self.backGroundImageView];
	NSLog(@"*******************************");
	[SDWebModel loadImageFor:self.networkImageView withRemoteURL:		self.channel.image_link];
        
        NSString *url = [NSString stringWithFormat:@"http://developer.tmsimg.com/%@?api_key=3w8hvfmfxjuwgvbqkahrss35", [self.channel.now_playing.preferredImage valueForKey:@"uri"]];
	
	[SDWebModel loadImageFor:self.backGroundImageView withRemoteURL:		url];
	
	self.titleLabel.text = self.channel.now_playing.title;
	if (self.channel.now_playing.duration > 59){
		if (self.channel.now_playing.duration % 60 == 0) {
			self.durationLabel.text = [NSString stringWithFormat:@"%ldh", (long)self.channel.now_playing.duration / 60];
		}else{
			self.durationLabel.text = [NSString stringWithFormat:@"%ldh %ldm", (long)self.channel.now_playing.duration / 60, (long)self.channel.now_playing.duration % 60];
		}
	}else {
		self.durationLabel.text = [NSString stringWithFormat:@"%ldm", (long)self.channel.now_playing.duration];
	}
}


@end
