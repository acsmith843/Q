//
//  TeamMember.m
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import "TeamMember.h"

@implementation TeamMember

- (id)initFromDictionary:(NSDictionary*)dict {
    
    self = [super init];
    
    _firstName = [dict objectForKey:@"firstName"];
    _lastName = [dict objectForKey:@"lastName"];
    _title = [dict objectForKey:@"title"];
    _imageUrl = [dict objectForKey:@"imageUrl"];
    
    return self;
}



#pragma mark - mock data

+ (NSMutableArray *) getMockTeamMembers {
    
    TeamMember *teamMember1 = [[TeamMember alloc] init];
    teamMember1.firstName = @"Ron";
    teamMember1.lastName = @"Burgundy";
    teamMember1.title = @"News Anchor";
    teamMember1.imageUrl = @"http://cdn.business2community.com/wp-content/uploads/2013/12/ron_burgundy_zps595ecdef.jpg";
    teamMember1.emailAddress = @"test@test.com";
    teamMember1.phoneNumber = @"843-555-1234";
    teamMember1.bio = @"Seitan organic bicycle rights, four loko tilde mlkshk food truck Vice. Cornhole cliche Pitchfork Godard swag cold-pressed 8-bit, fap cred meh Shoreditch beard wolf. High Life direct trade cliche authentic art party lomo small batch, health goth whatever actually +1 dreamcatcher ugh narwhal. Fap normcore hella chillwave. Freegan meditation wolf, umami pickled actually mixtape kitsch hoodie Marfa. High Life distillery wayfarers lo-fi. Shabby chic kogi street art, sriracha Schlitz retro migas literally Tumblr.";
    teamMember1.specialties = [NSArray arrayWithObjects:@"dogs", @"cats", @"mustaches", @"news", @"sex", nil];
    
    TeamMember *teamMember2 = [[TeamMember alloc] init];
    teamMember2.firstName = @"Veronica";
    teamMember2.lastName = @"Corningstone";
    teamMember2.title = @"News Anchor";
    teamMember2.imageUrl = @"http://img4.wikia.nocookie.net/__cb20120329161624/anchorman/images/e/ec/Veronica-corningstone1.jpg";
    teamMember2.emailAddress = @"test@test.com";
    teamMember2.phoneNumber = @"843-555-1234";
    teamMember2.bio = @"Seitan organic bicycle rights, four loko tilde mlkshk food truck Vice. Cornhole cliche Pitchfork Godard swag cold-pressed 8-bit, fap cred meh Shoreditch beard wolf. High Life direct trade cliche authentic art party lomo small batch, health goth whatever actually +1 dreamcatcher ugh narwhal. Fap normcore hella chillwave. Freegan meditation wolf, umami pickled actually mixtape kitsch hoodie Marfa. High Life distillery wayfarers lo-fi. Shabby chic kogi street art, sriracha Schlitz retro migas literally Tumblr.";
    teamMember2.specialties = [NSArray arrayWithObjects:@"men", @"news", @"fashion", nil];
    
    TeamMember *teamMember3 = [[TeamMember alloc] init];
    teamMember3.firstName = @"Brick";
    teamMember3.lastName = @"";
    teamMember3.title = @"Weatherman";
    teamMember3.imageUrl = @"http://img3.wikia.nocookie.net/__cb20120329162028/anchorman/images/0/0c/Brick-tamland-39895.jpg";
    teamMember3.emailAddress = @"test@test.com";
    teamMember3.phoneNumber = @"843-555-1234";
    teamMember3.bio = @"Seitan organic bicycle rights, four loko tilde mlkshk food truck Vice. Cornhole cliche Pitchfork Godard swag cold-pressed 8-bit, fap cred meh Shoreditch beard wolf. High Life direct trade cliche authentic art party lomo small batch, health goth whatever actually +1 dreamcatcher ugh narwhal. Fap normcore hella chillwave. Freegan meditation wolf, umami pickled actually mixtape kitsch hoodie Marfa. High Life distillery wayfarers lo-fi. Shabby chic kogi street art, sriracha Schlitz retro migas literally Tumblr.";
    teamMember3.specialties = [NSArray arrayWithObjects:@"i", @"love", @"lamp", nil];
    
    NSMutableArray *members = [[NSMutableArray alloc] initWithObjects:teamMember1, teamMember2, teamMember3, nil];
    
    return members;
}

@end
