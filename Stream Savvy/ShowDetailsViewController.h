//
//  ShowDetailsViewController.h
//  Stream Savvy
//
//  Created by Allen White on 8/29/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *mediaTitleText;
@property (weak, nonatomic) IBOutlet UILabel *mediaTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *netflixImageView;
@property (weak, nonatomic) IBOutlet UIImageView *huluImageView;

@end
