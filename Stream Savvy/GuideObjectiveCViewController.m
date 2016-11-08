//
//  GuideTableViewController.m
//  Stream Savvy
//
//  Created by Allen White on 8/23/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "GuideObjectiveCViewController.h"
#import "UserLocation.h"
#import "TopGridTableViewCell.h"
#import "Constants.h"
#import "Channel.h"
#import "LiveGuideTableViewCell.h"
#import "LiveGuideDetailsViewController.h"
#import "Stream_Savvy-Swift.h"

@interface GuideObjectiveCViewController ()
//@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;



- (NSArray *) getGuideShows;
@property (strong, nonatomic) UIBarButtonItem *loginButton;
@property (strong, nonatomic) UIBarButtonItem *searchButton;
@end


NSInteger numShowsPerCell = 3;
NSInteger numOfStaticCell = 1;


@implementation GuideObjectiveCViewController

- (NSArray *) getGuideShows {
        return _guideShows;
}

-(IBAction)goToLogin:(id)sender {
    [Auth0 resetAll];
    [self performSegueWithIdentifier:@"Login" sender:self];
}

-(IBAction)search:(id)sender
{
    
    if([self.navigationController isKindOfClass:[SearchNavigationControllerViewController class]])
    {
        [((SearchNavigationControllerViewController *)self.navigationController) search];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

	
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 34)];
	navigationImage.image=[UIImage imageNamed:@"streamsavvy-wordmark-large"];
	UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 34)];
	[workaroundImageView addSubview:navigationImage];
	self.navigationItem.titleView=workaroundImageView;
    
	self.tableView.rowHeight = UITableViewAutomaticDimension;
//	self.tableView.estimatedRowHeight = 328.0;
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
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    searchButton.tintColor = [Constants StreamSavvyRed];
    
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(goToLogin:)];
    loginButton.tintColor = [Constants StreamSavvyRed];
    
    
    NSArray *tempArray = [[NSArray alloc] initWithObjects:loginButton, searchButton, nil];
    self.navigationItem.rightBarButtonItems = tempArray;
    
    if (Auth0.loggedIn) {
        self.navigationItem.rightBarButtonItem = self.searchButton;
    } else {
        [self.loginButton setEnabled:YES];
        [self.loginButton setTintColor:[Constants StreamSavvyRed]];
    }
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
//		int max_to_load = 0;
		// itll crash if you uncomment all of these
					NSLog(@"\n\n\n\t\t0\n\n\n%@", JSON);
		////			NSLog(@"\n\n\n\t\t1\n\n\n%@", [[(NSArray *)JSON objectAtIndex:0] objectForKey:@"data"]);
		////			NSLog(@"\n\n\n\t\t2\n\n\n%@", [[[(NSArray *)JSON objectAtIndex:0] objectForKey:@"data"] objectForKey:@"GridScheduleResult"]);
		////			NSLog(@"\n\n\n\t\t3\n\n\n%@", [[[[(NSArray *)JSON objectAtIndex:0] objectForKey:@"data"] objectForKey:@"GridScheduleResult"]objectForKey:@"GridChannels"]);
		
		for (NSDictionary *region_channels in (NSArray *)JSON) {
//			if (max_to_load > 99) break;
//			max_to_load ++;
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
        return self.guideShows.count;
}

- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	return 68;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	LiveGuideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveGuideTableViewCell" forIndexPath:indexPath];
	[Constants fixSeparators:cell];
//	cell.channel = [self.guideShows objectAtIndex:indexPath.row];
//	cell.uivc = self;
//	[cell setCellDetails];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell * _Nonnull)cell forRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    if([cell isKindOfClass: [LiveGuideTableViewCell class]]){
        ((LiveGuideTableViewCell *)cell).channel = [self.guideShows objectAtIndex:indexPath.row];
        ((LiveGuideTableViewCell *)cell).uivc = self;
        [((LiveGuideTableViewCell * )cell) setCellDetails];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	Channel *channel = [self.guideShows objectAtIndex:indexPath.row];
	LiveGuideDetailsViewController *lgdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveDetailsViewController"];
	NSLog(@"HERE");
	lgdvc.channel = channel;
	lgdvc.media = channel.now_playing;
	[self.navigationController pushViewController:lgdvc animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Login"]){
        Auth0ViewController *vc = [segue destinationViewController];
        vc.fromSegue = true;
        
    }
}

@end
