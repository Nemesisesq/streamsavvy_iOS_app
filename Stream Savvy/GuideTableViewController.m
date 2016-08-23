//
//  GuideTableViewController.m
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "GuideTableViewController.h"
#import "UserLocation.h"
#import "LeftGridTableViewCell.h"
#import "RightGridTableViewCell.h"

@interface GuideTableViewController ()

@property (strong, nonatomic) NSArray *popularShows;

@end

NSInteger showsPerCell = 3;

@implementation GuideTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[UserLocation sharedController]setDelegate:self];
	[[UserLocation sharedController].locationManager startUpdatingLocation];
	
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[[UserLocation sharedController].locationManager stopUpdatingLocation];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.popularShows.count / showsPerCell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2 == 0) {
		LeftGridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftGridTableViewCell" forIndexPath:indexPath];
		cell.bigShow = [self.popularShows objectAtIndex:(indexPath.row * showsPerCell)];
		cell.topShow = [self.popularShows objectAtIndex:(indexPath.row * showsPerCell + 1)];
		cell.bottomShow = [self.popularShows objectAtIndex:(indexPath.row * showsPerCell + 2)];
		[cell setCellDetails];
		return cell;
	}else{
		RightGridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightGridTableViewCell" forIndexPath:indexPath];
		cell.bigShow = [self.popularShows objectAtIndex:(indexPath.row * showsPerCell)];
		cell.topShow = [self.popularShows objectAtIndex:(indexPath.row * showsPerCell + 1)];
		cell.bottomShow = [self.popularShows objectAtIndex:(indexPath.row * showsPerCell + 2)];
		[cell setCellDetails];
		return cell;
	}
}

@end
