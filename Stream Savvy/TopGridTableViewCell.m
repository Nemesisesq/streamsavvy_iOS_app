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
#import "ShowDetailsViewController.h"


@implementation TopGridTableViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	// Initialization code
	[Constants addGradientForImageView:self.topImageView];
	[Constants addGradientForImageView:self.bottomImageView];
	[Constants addGradientForImageView:self.bigImageView];
	
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topPressed)];
	[self.topImageView addGestureRecognizer:tapGestureRecognizer];
	[self.topImageView setUserInteractionEnabled:YES];
	
	tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomPressed)];
	[self.bottomImageView addGestureRecognizer:tapGestureRecognizer];
	[self.bottomImageView setUserInteractionEnabled:YES];
	
	tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigPressed)];
	[self.bigImageView addGestureRecognizer:tapGestureRecognizer];
	[self.bigImageView setUserInteractionEnabled:YES];
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
		self.bigImageTimeLabel.text											= self.bigShow.time;
		self.topImageTimeLabel.text											= self.topShow.time;
		self.bottomImageTimeLabel.text										= self.bottomShow.time;
	}else{
		[SDWebModel loadImageFor:self.bigImageView withRemoteURL:		self.bigChannel.image_link];
		[SDWebModel loadImageFor:self.topImageView withRemoteURL:		self.topChannel.image_link];
		[SDWebModel loadImageFor:self.bottomImageView withRemoteURL:	self.bottomChannel.image_link];
		self.bigImageTitleLabel.text											= self.bigChannel.now_playing.title;
		self.topImageTitleLabel.text											= self.topChannel.now_playing.title;
		self.bottomImageTitleLabel.text										= self.bottomChannel.now_playing.title;
		self.bigImageTimeLabel.text											= self.bigChannel.now_playing.time;
		self.topImageTimeLabel.text											= self.topChannel.now_playing.time;
		self.bottomImageTimeLabel.text										= self.bottomChannel.now_playing.time;
	}

}


-(void)topPressed{
	ShowDetailsViewController *sdvc = [self.uivc.storyboard instantiateViewControllerWithIdentifier:@"ShowDetailsViewController"];
	if (self.isShowingPopularShows) {
		sdvc.mediaTitleText = self.topShow.title;
	}else{
		sdvc.mediaTitleText = self.topChannel.now_playing.title;
	}
	sdvc.isDisplayingPopularShows = self.isShowingPopularShows;
	[self.uivc.navigationController pushViewController:sdvc animated:YES];
}

-(void)bottomPressed{
	ShowDetailsViewController *sdvc = [self.uivc.storyboard instantiateViewControllerWithIdentifier:@"ShowDetailsViewController"];
	if (self.isShowingPopularShows) {
		sdvc.mediaTitleText = self.bottomShow.title;
	}else{
		sdvc.mediaTitleText = self.bottomChannel.now_playing.title;
	}
	sdvc.isDisplayingPopularShows = self.isShowingPopularShows;
	[self.uivc.navigationController pushViewController:sdvc animated:YES];
}

-(void)bigPressed{
	ShowDetailsViewController *sdvc = [self.uivc.storyboard instantiateViewControllerWithIdentifier:@"ShowDetailsViewController"];
	if (self.isShowingPopularShows) {
		sdvc.mediaTitleText = self.bigShow.title;
	}else{
		sdvc.mediaTitleText = self.bigChannel.now_playing.title;
	}
	sdvc.isDisplayingPopularShows = self.isShowingPopularShows;
	[self.uivc.navigationController pushViewController:sdvc animated:YES];
}

@end
