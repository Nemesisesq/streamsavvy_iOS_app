//
//  PopularShowTableViewController.h
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthViewController.h"

@interface PopularShowObjectiveCViewController : AuthViewController

@property (strong, nonatomic) NSArray *popularShows;

-(void)reload;

@property (strong, nonatomic) NSString *nextPage;

@property (strong, nonatomic) NSString *previous;


@end
