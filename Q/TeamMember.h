//
//  TeamMember.h
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamMember : NSObject

@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *bio;
@property (nonatomic,strong) NSArray *specialties;

- (id)initFromDictionary:(NSDictionary*)dict;

+ (NSMutableArray *) getMockTeamMembers;

@end
