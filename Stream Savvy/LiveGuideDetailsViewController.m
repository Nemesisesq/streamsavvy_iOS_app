//
//  LiveGuideDetailsViewController.m
//  Stream Savvy
//
//  Created by Allen White on 10/3/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "LiveGuideDetailsViewController.h"
#import "SDWebModel.h"

@interface LiveGuideDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *mediaTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *channelImageView;

@end

@implementation LiveGuideDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.durationLabel.text = [NSString stringWithFormat:@"%ld min", (long)self.media.duration];
	NSString *genres = @"";
	for (NSString *genre in self.media.genres) {
		genres = [NSString stringWithFormat:@"%@ | %@", genres, genre];
	}
	NSLog(@"%@", genres);
	genres = [genres substringFromIndex:3];
	NSLog(@"%@", genres);
	self.genresLabel.text = genres;
	self.mediaTitleLabel.text = self.media.title;
	self.channelNumberLabel.text = [NSString stringWithFormat:@"Channel %@", self.channel.channel_number];
	
	[SDWebModel loadImageFor:self.channelImageView withRemoteURL:self.channel.image_link];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
