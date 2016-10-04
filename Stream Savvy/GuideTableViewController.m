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
	NSLog(@"sharedController: %@", UserLocation.sharedController);
	[UserLocation.sharedController.locationManager startUpdatingLocation];
	NSLog(@"startUpdatingLocation");
	
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[UserLocation.sharedController.locationManager stopUpdatingLocation];
	NSLog(@"stopUpdatingLocation");
}


-(void)reload{
	float lat = UserLocation.sharedController.locationManager.location.coordinate.latitude;
	float lon = UserLocation.sharedController.locationManager.location.coordinate.longitude;
	[Channel getGuideForLattitude:lat Longitude:lon view:self.view Success:^(NSURLSessionDataTask *task, id JSON) {
		NSMutableArray *guideShows = [NSMutableArray new];
		//////////////////////this needs edited
		int max_to_load = 0;
		// itll crash if you uncomment all of these
					NSLog(@"\n\n\n\t\t0\n\n\n%@", JSON);
		////			NSLog(@"\n\n\n\t\t1\n\n\n%@", [[(NSArray *)JSON objectAtIndex:0] objectForKey:@"data"]);
		////			NSLog(@"\n\n\n\t\t2\n\n\n%@", [[[(NSArray *)JSON objectAtIndex:0] objectForKey:@"data"] objectForKey:@"GridScheduleResult"]);
		////			NSLog(@"\n\n\n\t\t3\n\n\n%@", [[[[(NSArray *)JSON objectAtIndex:0] objectForKey:@"data"] objectForKey:@"GridScheduleResult"]objectForKey:@"GridChannels"]);
		
		for (NSDictionary *region_channels in (NSArray *)JSON) {
			if (max_to_load > 99) break;
			max_to_load ++;
			[guideShows addObject:[[Channel alloc] initWithAttributes: region_channels]];
		}
		self.guideShows = [guideShows copy];
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
    return (numOfStaticCell + self.guideShows.count / numShowsPerCell);
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
	cell.bigChannel = [self.guideShows objectAtIndex:((indexPath.row - numOfStaticCell) * numShowsPerCell)];
	cell.topChannel = [self.guideShows objectAtIndex:((indexPath.row - numOfStaticCell) * numShowsPerCell + 1)];
	cell.bottomChannel = [self.guideShows objectAtIndex:((indexPath.row - numOfStaticCell) * numShowsPerCell + 2)];
	cell.uivc = self;
	[cell setCellDetails];
	
	return cell;
}

@end
