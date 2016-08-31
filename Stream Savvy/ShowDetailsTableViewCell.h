//
//  ShowDetailsTableViewCell.h
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularShow.h"
#import "Media.h"

@interface ShowDetailsTableViewCell : UITableViewCell

@property (strong, nonatomic) PopularShow *show;
@property (strong, nonatomic) PopularShow *media;

@property (nonatomic) BOOL isDisplayingPopularShows;
@property (weak, nonatomic) IBOutlet UILabel *mediaTitleLabel;
-(void)setCellDetails;


@end
