//
//  MediaSourceTableViewCell.m
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "MediaSourceTableViewCell.h"
#import "SDWebModel.h"

@implementation MediaSourceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellDetails{
	[SDWebModel loadImageFor:self.mediaSourceImageView withRemoteURL:self.source.image_link];
}

@end
