//
//  Utils.m
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)makeViewRounded:(UIView*)view{
    
    view.clipsToBounds = YES;
    [view.layer setCornerRadius:view.frame.size.width/2];
}
@end
