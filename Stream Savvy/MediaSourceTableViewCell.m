//
//  MediaSourceTableViewCell.m
//  Stream Savvy
//
//  Created by Allen White on 8/30/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "MediaSourceTableViewCell.h"
#import "SDWebModel.h"
#import "Constants.h"
#import "WebViewViewController.h"

@implementation MediaSourceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mediaPressed)];
    [self.mediaSourceImageView addGestureRecognizer:tapGestureRecognizer];
    [self.mediaSourceImageView setUserInteractionEnabled:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setCellDetails{
    [Constants AWLog:self.source.source LINE:__LINE__ FUNCTION:__FUNCTION__];
    self.mediaSourceImageView.image = [UIImage imageNamed: self.source.source];
}

-(BOOL)schemeAvailable: (NSString *)scheme {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    return [application canOpenURL:URL];
}


-(NSString *)getDeepLink{
    for (NSString *link in self.source.deep_links){
        if([self schemeAvailable: link]){
            return link;
        }
        
    }
    
    return @"";
    
}

-(void)mediaPressed{
    //	WebViewViewController *wvvc = [self.sdtvc.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
    //	wvvc.urlToLoad =self.source.deep_link;
    ////	[self.sdtvc showViewController:wvvc sender:nil];
    //	[self.sdtvc presentViewController:wvvc animated:YES completion:nil];
    
    id view  = [self superview];
    
    UITableView *tableView = (UITableView *)view;
    
    
    
    if([self.source.app_store_link isEqual: @""]){
        
        //[tableView makeToast: @"There is no app for this service"];
        
    } else {
        
        
        
        if (![[self getDeepLink]  isEqual: @""]){
            
            NSString *deep_link = [self getDeepLink];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: deep_link]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.source.app_store_link]];
        }
    }
    //TODO: hande scenario where there is no deep link or appstore link
    
    
    
}


@end
