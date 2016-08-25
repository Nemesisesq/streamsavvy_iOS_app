//
//  GuideTableViewController.m
//  Stream Savvy
//
//  Created by Allen White on 8/23/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "GuideTableViewController.h"
#import "UserLocation.h"
#import "TopGridTableViewCell.h"
#import "Constants.h"
#import "Channel.h"

@interface GuideTableViewController ()

@property (strong, nonatomic) NSArray *guideShows;

@end


NSInteger numShowsPerCell = 3;
NSInteger numOfStaticCell = 1;


@implementation GuideTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 34)];
	navigationImage.image=[UIImage imageNamed:@"streamsavvy-wordmark-large"];
	
	UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 34)];
	[workaroundImageView addSubview:navigationImage];
	self.navigationItem.titleView=workaroundImageView;
	
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.estimatedRowHeight = 60.0;
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
	// this is fucking gnarly lol
	[UserLocation getLocationFromIP:^(NSURLSessionDataTask *task, id JSON) {
		NSInteger zip_code = [[(NSDictionary *)JSON valueForKey:@"zip_code"] integerValue];
		NSLog(@"zip_code %ld", (long)zip_code);
		[Channel getRoviGuideForZipcode:43021 Success:^(NSURLSessionDataTask *task, id JSON) {
			NSMutableArray *guideShows = [NSMutableArray new];
			//////////////////////this needs edited
			for (NSDictionary *region_channels in (NSArray *)JSON) {
				for (NSDictionary *channel in [[[region_channels objectForKey:@"data"] objectForKey:@"GridScheduleResult"] objectForKey:@"GridChannels"]) {
					[guideShows addObject:[[Channel alloc] initWithAttributes: channel]];
				}
			}
			self.guideShows = [guideShows copy];
			[self.tableView reloadData];
			if (self.refreshControl) {
				[self.refreshControl endRefreshing];
			}
		}];
	}];
	
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numOfStaticCell + self.guideShows.count / numShowsPerCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell" forIndexPath:indexPath];
		[Constants fixSeparators:cell];
		return cell;
	}
	TopGridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopGridTableViewCell" forIndexPath:indexPath];
	[Constants fixSeparators:cell];
	cell.isShowingPopularShows = NO;
	cell.bigShow = [self.guideShows objectAtIndex:((indexPath.row - numOfStaticCell) * numShowsPerCell)];
	cell.topShow = [self.guideShows objectAtIndex:((indexPath.row - numOfStaticCell) * numShowsPerCell + 1)];
	cell.bottomShow = [self.guideShows objectAtIndex:((indexPath.row - numOfStaticCell) * numShowsPerCell + 2)];
	[cell setCellDetails];
	return cell;
}

@end
