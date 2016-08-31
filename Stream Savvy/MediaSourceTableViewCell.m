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
	[Constants AWLog:self.source.source LINE:__LINE__ FUNCTION:__FUNCTION__];
	self.mediaSourceImageView.image = [UIImage imageNamed: self.source.source];
}

@end
