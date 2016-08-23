//
//  Constants.m
//  Stream Savvy
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import "Constants.h"

@implementation Constants


+(void)showAlert:(NSString *)title withMessage:(NSString *)message fromController:(UIViewController *)vc{
	UIAlertController * alert=   [UIAlertController
				      alertControllerWithTitle:title
				      message:message
				      preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction* ok = [UIAlertAction
			     actionWithTitle:@"Okay"
			     style:UIAlertActionStyleDefault
			     handler:^(UIAlertAction * action){
				     [alert dismissViewControllerAnimated:YES completion:nil];
			     }];
	[alert addAction:ok];
	[vc presentViewController:alert animated:YES completion:nil];
}


+ (void)showAlert:(NSString *)title withMessage:(NSString *)message{
	UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:title
							   message:message
							  delegate:self
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
	[theAlert show];
}




+(void)fixSeparators:(UITableViewCell *)cell{
	// Remove seperator inset
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	// Prevent the cell from inheriting the Table View's margin settings
	if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
		[cell setPreservesSuperviewLayoutMargins:NO];
	}
	// Explictly set your cell's layout margins
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
	[cell setNeedsUpdateConstraints];
	[cell updateConstraintsIfNeeded];
}


+(UIColor *)r:(int)red g:(int)green b:(int)blue a:(float)alpha{
	return [UIColor colorWithRed:(float)red/255.0f green:(float)green/255.0f blue:(float)blue/255.0f alpha:alpha];
	
}


+(UIColor *)StreamSavvyRed{
	return [self r:240 g:3 b:42 a:1];
}


+(NSString *)trim:(NSString *)string{
	return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+(void)AWLog:(NSObject *)log LINE:(int)__LINE_ FUNCTION:(const char *)__PRETTY_FUNCTION_{
	NSLog(@"\t\t\t%d\t\t%s\t\t%@", __LINE_, __PRETTY_FUNCTION_, log);
}



@end
