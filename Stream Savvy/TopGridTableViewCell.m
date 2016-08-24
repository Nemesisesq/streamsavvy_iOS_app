//
//  TopGridTableViewCell.m
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "TopGridTableViewCell.h"
#import "SDWebModel.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

@implementation TopGridTableViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	// Initialization code
	[Constants addGradientForImageView:self.bigImageView];
	[Constants addGradientForImageView:self.topImageView];
	[Constants addGradientForImageView:self.bottomImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellDetails{
	if (self.isShowingPopularShows) {
		[SDWebModel loadImageFor:self.bigImageView withRemoteURL:		self.bigShow.image_link];
		[SDWebModel loadImageFor:self.topImageView withRemoteURL:		self.topShow.image_link];
		[SDWebModel loadImageFor:self.bottomImageView withRemoteURL:	self.bottomShow.image_link];
		self.bigImageTitleLabel.text											= self.bigShow.title;
		self.topImageTitleLabel.text											= self.topShow.title;
		self.bottomImageTitleLabel.text										= self.bottomShow.title;
	}else{
		[SDWebModel loadImageFor:self.bigImageView withRemoteURL:		self.bigChannel.image_link];
		[SDWebModel loadImageFor:self.topImageView withRemoteURL:		self.topChannel.image_link];
		[SDWebModel loadImageFor:self.bottomImageView withRemoteURL:	self.bottomChannel.image_link];
		self.bigImageTitleLabel.text											= self.bigChannel.now_playing.title;
		self.topImageTitleLabel.text											= self.topChannel.now_playing.title;
		self.bottomImageTitleLabel.text										= self.bottomChannel.now_playing.title;
	}
}

@end
