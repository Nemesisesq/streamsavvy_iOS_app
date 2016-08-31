//
//  ShowDetailsTableViewCell.m
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "ShowDetailsTableViewCell.h"

@implementation ShowDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCellDetails{
	NSLog(@"setCellDetails");
	if (self.isDisplayingPopularShows) {
		NSLog(@"#");
		NSLog(@"%@", self.show.title);
		self.mediaTitleLabel.text = self.show.title;
	}else{
		NSLog(@"&");
		self.mediaTitleLabel.text = self.media.title;
	}
}

@end
