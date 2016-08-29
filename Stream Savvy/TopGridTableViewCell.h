//
//  TopGridTableViewCell.h
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularShow.h"
#import "Channel.h"

@interface TopGridTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (weak, nonatomic) IBOutlet UILabel *bigImageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *topImageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomImageTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *bigImageTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *topImageTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomImageTimeLabel;

@property (nonatomic) BOOL isShowingPopularShows;
@property (strong, nonatomic) PopularShow *bigShow;
@property (strong, nonatomic) PopularShow *topShow;
@property (strong, nonatomic) PopularShow *bottomShow;

@property (strong, nonatomic) Channel *bigChannel;
@property (strong, nonatomic) Channel *topChannel;
@property (strong, nonatomic) Channel *bottomChannel;

-(void)setCellDetails;

@end
