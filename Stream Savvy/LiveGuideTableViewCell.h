//
//  LiveGuideTableViewCell.h
//  Stream Savvy
//
//  Created by Allen White on 10/22/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"

@interface LiveGuideTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *networkImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (strong, nonatomic) Channel *channel;
@property (strong, nonatomic) UIViewController *uivc;

-(void)setCellDetails;

@end
