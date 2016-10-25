//
//  GuideTableViewController.h
//  Stream Savvy
//
//  Created by Allen White on 8/23/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthTableViewController.h"


@interface GuideObjectiveCViewController: UIViewController

@property (strong, nonatomic) NSArray *guideShows;

-(void) reload;

@end
