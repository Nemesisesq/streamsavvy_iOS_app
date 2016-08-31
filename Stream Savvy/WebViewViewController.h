//
//  WebViewViewController.h
//  Stream Savvy
//
//  Created by Allen White on 8/31/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *urlToLoad;
@end
