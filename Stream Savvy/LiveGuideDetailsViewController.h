//
//  LiveGuideDetailsViewController.h
//  Stream Savvy
//
//  Created by Allen White on 10/3/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Media.h"
#import "Channel.h"

@interface LiveGuideDetailsViewController : UIViewController

@property (strong, nonatomic) Channel *channel;
@property (strong, nonatomic) Media *media;


@end
