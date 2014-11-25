//
//  TeamMemberSpecialtiesCell.m
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import "TeamMemberSpecialtiesCell.h"

@implementation TeamMemberSpecialtiesCell

- (void)awakeFromNib {
    // Initialization code
    
    // style the tags
    [[AMTagView appearance] setTagColor:[UIColor clearColor]];
    [[AMTagView appearance] setTextColor:[UIColor cyanColor]];
    [[AMTagView appearance] setInnerTagPadding:0];
    self.tagListView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
