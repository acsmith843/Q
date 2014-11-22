//
//  TeamMemberCell.m
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import "TeamMemberCell.h"
#import "Utils.h"

@implementation TeamMemberCell

- (void)awakeFromNib {
    
    // Initialization code
    
    //round image
    [Utils makeViewRounded:_profileImage];
    
    //add border to cell
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.backgroundColor = [UIColor clearColor];
}

@end
