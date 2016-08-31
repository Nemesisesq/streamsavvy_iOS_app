//
//  MediaSourceTableViewCell.h
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaSource.h"

@interface MediaSourceTableViewCell : UITableViewCell

@property (strong, nonatomic) MediaSource *source;
@property (weak, nonatomic) IBOutlet UIImageView *mediaSourceImageView;
-(void)setCellDetails;

@end
