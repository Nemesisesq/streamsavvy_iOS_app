//
//  Constants.h
//  Stream Savvy
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Constants : NSObject

+(void)showAlert:(NSString *)title withMessage:(NSString *)message fromController:(UIViewController *)vc;
+(void)fixSeparators:(UITableViewCell *)cell;

+(UIColor *)r:(int)red g:(int)green b:(int)blue a:(float)alpha;

+(UIColor *)StreamSavvyRed;


@end
