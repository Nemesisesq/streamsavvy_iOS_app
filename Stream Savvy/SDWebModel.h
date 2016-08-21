//
//  SDWebModel.h
//  Stream Savvy
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 OhioBizDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SDWebModel : NSObject

+(void)loadImageFor:(UIImageView *)imageView withRemoteURL:(NSString *)url;

@end
