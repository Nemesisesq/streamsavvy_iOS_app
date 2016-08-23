//
//  LeftGridTableViewCell.h
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularShow.h"

@interface LeftGridTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (weak, nonatomic) IBOutlet UILabel *bigImageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *topImageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomImageTitleLabel;

@property (strong, nonatomic) PopularShow *bigShow;
@property (strong, nonatomic) PopularShow *topShow;
@property (strong, nonatomic) PopularShow *bottomShow;
-(void)setCellDetails;

@end
