//
//  PopularShowTableViewController.m
//  Stream Savvy
//
//  Created by Allen White on 8/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "PopularShowTableViewController.h"
#import "UserLocation.h"
#import "TopGridTableViewCell.h"
#import "Constants.h"
#import "PopularShow.h"
#import "ShowDetailsViewController.h"

@interface PopularShowTableViewController ()

@property (strong, nonatomic) NSArray *popularShows;

@end

NSInteger showsPerCell = 3;
NSInteger numStaticCell = 1;

@implementation PopularShowTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 34)];
	navigationImage.image=[UIImage imageNamed:@"streamsavvy-wordmark-large"];
	
	UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 34)];
	[workaroundImageView addSubview:navigationImage];
	self.navigationItem.titleView=workaroundImageView;
	
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.estimatedRowHeight = 328.0;
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	[self.tableView setSeparatorColor:[UIColor blackColor]];
	
	self.refreshControl = [[UIRefreshControl alloc] init];
	self.refreshControl.backgroundColor = [UIColor blackColor];
	self.refreshControl.tintColor = [Constants StreamSavvyRed];
	[self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
	[self.tableView addSubview:self.refreshControl];
	[self reload];
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

-(void)reload{
	[PopularShow getPopularShowsForPage:0 Success:^(NSURLSessionDataTask *task, id JSON) {
		
		
		NSMutableArray *popularShows = [NSMutableArray new];
		for (NSDictionary *result in [(NSDictionary *)JSON objectForKey:@"results"]) {
			[popularShows addObject:[[PopularShow alloc] initWithAttributes:result]];
		}
		self.popularShows = [popularShows copy];
		[self.tableView reloadData];
		if (self.refreshControl) {
			[self.refreshControl endRefreshing];
		}
	}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numStaticCell + self.popularShows.count / showsPerCell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell" forIndexPath:indexPath];
		[Constants fixSeparators:cell];
		return cell;
	}
	TopGridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopGridTableViewCell" forIndexPath:indexPath];
	[Constants fixSeparators:cell];
	cell.isShowingPopularShows = YES;
	cell.bigShow = [self.popularShows objectAtIndex:((indexPath.row - numStaticCell) * showsPerCell)];
	cell.topShow = [self.popularShows objectAtIndex:((indexPath.row - numStaticCell) * showsPerCell + 1)];
	cell.bottomShow = [self.popularShows objectAtIndex:((indexPath.row - numStaticCell) * showsPerCell + 2)];
	cell.uivc = self;
	[cell setCellDetails];
	return cell;
}

@end
