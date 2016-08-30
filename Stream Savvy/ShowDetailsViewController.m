//
//  ShowDetailsViewController.m
//  Stream Savvy
//
//  Created by Allen White on 8/29/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "ShowDetailsViewController.h"

@interface ShowDetailsViewController ()

@end

@implementation ShowDetailsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	NSLog(@"%@",self.mediaTitleText);
	self.mediaTitleLabel.text = self.mediaTitleText;
	if (!self.isDisplayingPopularShows) {
		self.netflixImageView.image = [UIImage imageNamed:@"sling"];
	}

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
