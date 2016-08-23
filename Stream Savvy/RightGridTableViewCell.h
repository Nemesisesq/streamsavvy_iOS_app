//
//  RightGridTableViewCell.h
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularShow.h"

@interface RightGridTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (strong, nonatomic) PopularShow *bigShow;
@property (strong, nonatomic) PopularShow *topShow;
@property (strong, nonatomic) PopularShow *bottomShow;
-(void)setCellDetails;

@end
