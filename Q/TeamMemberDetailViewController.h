//
//  TeamMemberDetailViewController.h
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamMember.h"

@interface TeamMemberDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) TeamMember *currentTeamMember;

@end
