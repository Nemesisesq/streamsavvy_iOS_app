//
//  MediaSourceTableViewCell.m
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "MediaSourceTableViewCell.h"
#import "SDWebModel.h"
#import "Constants.h"
#import "WebViewViewController.h"

@implementation MediaSourceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mediaPressed)];
	[self.mediaSourceImageView addGestureRecognizer:tapGestureRecognizer];
	[self.mediaSourceImageView setUserInteractionEnabled:YES];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellDetails{
	[Constants AWLog:self.source.source LINE:__LINE__ FUNCTION:__FUNCTION__];
	self.mediaSourceImageView.image = [UIImage imageNamed: self.source.source];
}


-(void)mediaPressed{
	WebViewViewController *wvvc = [self.sdtvc.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
	wvvc.urlToLoad =self.source.deep_link;
//	[self.sdtvc showViewController:wvvc sender:nil];
	[self.sdtvc presentViewController:wvvc animated:YES completion:nil];
	
}


@end
