//
//  Utils.h
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (void)makeViewRounded: (UIView *) view;

+ (UIImage *) blurSnapshotDarkEffect : (UIViewController *) currentViewController;

@end
