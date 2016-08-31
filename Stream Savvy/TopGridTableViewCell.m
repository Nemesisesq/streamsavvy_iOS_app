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
#import "ShowDetailsTableViewController.h"
#import "MediaSource.h"

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
	ShowDetailsTableViewController *sdtvc = [self.uivc.storyboard instantiateViewControllerWithIdentifier:@"ShowDetailsTableViewController"];
	if (self.isShowingPopularShows) {
		[self.topShow getShowDetailsWithView:self.uivc.view Success:^(NSURLSessionDataTask *task, id JSON) {
			sdtvc.show = self.topShow;
			sdtvc.sources = [self getSourcesFromShowWithJSON:(NSDictionary *)JSON];
			sdtvc.isDisplayingPopularShows = self.isShowingPopularShows;
			[self.uivc.navigationController pushViewController:sdtvc animated:YES];
		}];
	}else{
		sdtvc.isDisplayingPopularShows = self.isShowingPopularShows;
		sdtvc.media = self.topChannel.now_playing;
		sdtvc.sources = [self staticSources];
		[self.uivc.navigationController pushViewController:sdtvc animated:YES];
	}
}

-(void)bottomPressed{
	ShowDetailsTableViewController *sdtvc = [self.uivc.storyboard instantiateViewControllerWithIdentifier:@"ShowDetailsTableViewController"];
	if (self.isShowingPopularShows) {
		[self.bottomShow getShowDetailsWithView:self.uivc.view Success:^(NSURLSessionDataTask *task, id JSON) {
			sdtvc.show = self.bottomShow;
			sdtvc.sources = [self getSourcesFromShowWithJSON:(NSDictionary *)JSON];
			sdtvc.isDisplayingPopularShows = self.isShowingPopularShows;
			[self.uivc.navigationController pushViewController:sdtvc animated:YES];
		}];
	}else{
		sdtvc.isDisplayingPopularShows = self.isShowingPopularShows;
		sdtvc.media = self.bottomChannel.now_playing;
		sdtvc.sources = [self staticSources];
		[self.uivc.navigationController pushViewController:sdtvc animated:YES];
	}
}

-(void)bigPressed{
	ShowDetailsTableViewController *sdtvc = [self.uivc.storyboard instantiateViewControllerWithIdentifier:@"ShowDetailsTableViewController"];
	if (self.isShowingPopularShows) {
		[self.bigShow getShowDetailsWithView:self.uivc.view Success:^(NSURLSessionDataTask *task, id JSON) {
			sdtvc.show = self.bigShow;
			sdtvc.sources = [self getSourcesFromShowWithJSON:(NSDictionary *)JSON];
			sdtvc.isDisplayingPopularShows = self.isShowingPopularShows;
			[self.uivc.navigationController pushViewController:sdtvc animated:YES];
		}];
	}else{
		sdtvc.isDisplayingPopularShows = self.isShowingPopularShows;
		sdtvc.media = self.bigChannel.now_playing;
		sdtvc.sources = [self staticSources];
		[self.uivc.navigationController pushViewController:sdtvc animated:YES];
	}
}

-(NSArray *)getSourcesFromShowWithJSON:(NSDictionary *)json{
	NSArray *live			= [json objectForKey:@"live"];
	NSArray *pay_per_view	= [json objectForKey:@"pay_per_view"];
	NSArray *on_demand	= [json objectForKey:@"on_demand"];
	NSArray *sources = [[NSSet setWithArray:[[live arrayByAddingObjectsFromArray:pay_per_view] arrayByAddingObjectsFromArray:on_demand]] allObjects];
	NSMutableArray *media_sources = [NSMutableArray new];
	NSLog(@"Sources LENGTH: %lu", (unsigned long)sources.count);
	for (NSDictionary *dict in sources) {
		MediaSource *source = [[MediaSource alloc] initWithAttributes:dict];
		[media_sources addObject:source];
	}
	return [media_sources copy];
}

-(NSArray *)staticSources{
	NSArray *source_dicts = @[
				  @{
					  @"display_name":@"Sling Orange",
					  @"source":@"sling_orange"
					  },
				  @{
					  @"display_name":@"Sling Blue",
					  @"source":@"sling_blue"
					  },
				  @{
					  @"display_name":@"Sling Blue Orange",
					  @"source":@"sling_blue_orange"
					  },
				  @{
					  @"display_name":@"Sony Vue Core",
					  @"source":@"sony_vue_core"
					  },
				  @{
					  @"display_name":@"Sony Vue Elite",
					  @"source":@"sony_vue_elite"
					  },
				  @{
					  @"display_name":@"Sony Vue Slim",
					  @"source":@"sony_vue_slim"
					  },
				  ];
	
	NSMutableArray *media_sources = [NSMutableArray new];
	for (NSDictionary *dict in source_dicts) {
		MediaSource *source = [[MediaSource alloc] initWithAttributes:dict];
		[media_sources addObject:source];
	}
	return [media_sources copy];

}

@end
