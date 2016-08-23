//
//  LeftGridTableViewCell.m
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "LeftGridTableViewCell.h"
#import "SDWebModel.h"

@implementation LeftGridTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellDetails{
	[SDWebModel loadImageFor:self.bigImageView withRemoteURL:self.bigShow.image_link];
	[SDWebModel loadImageFor:self.topImageView withRemoteURL:self.topShow.image_link];
	[SDWebModel loadImageFor:self.bottomImageView withRemoteURL:self.bottomShow.image_link];
}

@end
