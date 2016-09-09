//
//  ShowDetailsTableViewController.m
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "ShowDetailsTableViewController.h"
#import "ShowDetailsTableViewCell.h"
#import "MediaSourceTableViewCell.h"

@interface ShowDetailsTableViewController ()

@end

@implementation ShowDetailsTableViewController


NSInteger numStaticCells = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.estimatedRowHeight = 328.0;
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	[self.tableView setSeparatorColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sources.count + numStaticCells;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^");
	if (indexPath.row == 0) {
		ShowDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowDetailsTableViewCell" forIndexPath:indexPath];
		cell.isDisplayingPopularShows = self.isDisplayingPopularShows;
		if (self.isDisplayingPopularShows) {
			cell.show = self.show;
		}else{
			cell.media = self.media;
		}
		[cell setCellDetails];
		return cell;
	}
	NSLog(@"\n\n\nset up sources\n\n\n");
	MediaSourceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MediaSourceTableViewCell" forIndexPath:indexPath];
	NSLog(@"\n\n\ndequeue\n\n\n");
	cell.source = [self.sources objectAtIndex:indexPath.row - numStaticCells];
	NSLog(@"\n\n\nset source\n\n\n");
	cell.sdtvc = self;
	NSLog(@"\n\n\ni am ur parent\n\n\n");
	[cell setCellDetails];
	NSLog(@"\n\n\nset cell details\n\n\n");
	return cell;
}


@end
