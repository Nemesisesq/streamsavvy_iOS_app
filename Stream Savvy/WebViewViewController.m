//
//  WebViewViewController.m
//  Stream Savvy
//
//  Created by Allen White on 8/31/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
	NSString *urlString = self.urlToLoad;
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonTapped:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
