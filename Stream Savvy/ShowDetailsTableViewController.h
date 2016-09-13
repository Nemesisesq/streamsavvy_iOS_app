//
//  ShowDetailsTableViewController.h
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Toast/UIView+Toast.h>
#import "PopularShow.h"
#import "Media.h"
#import "AuthTableViewController.h"


@interface ShowDetailsTableViewController : AuthTableViewController

@property (strong, nonatomic) PopularShow *show;

@property (strong, nonatomic) Media *media;

@property (nonatomic) BOOL isDisplayingPopularShows;

@property (strong, nonatomic)NSArray *sources;

-(void)ssToaster:(NSString *)message;

@end
