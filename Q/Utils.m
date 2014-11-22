//
//  Utils.m
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import "Utils.h"
#import "UIImage+ImageEffects.h"

@implementation Utils

+ (void)makeViewRounded:(UIView*)view{
    
    view.clipsToBounds = YES;
    [view.layer setCornerRadius:view.frame.size.width/2];
}

+ (UIImage *) blurSnapshotDarkEffect : (UIViewController *) currentViewController {
    
    // create image context
    UIGraphicsBeginImageContextWithOptions(currentViewController.view.bounds.size, NO, 0);
    
    // render a snapshot of the view hierarchy into the current context
    [currentViewController.view drawViewHierarchyInRect:currentViewController.view.frame afterScreenUpdates:NO];
    
    // grabs snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // apply blur effect using apple code
    UIImage *blurredImage = [snapshotImage applyDarkEffect];
    
    // clean up
    UIGraphicsEndImageContext();
    
    return blurredImage;
}

@end
