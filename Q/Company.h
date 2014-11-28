//
//  Company.h
//  Q
//
//  Created by Adam C. Smith on 11/28/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *logoUrl;
@property (nonatomic,strong) NSString *secondaryLogoUrl;
@property (nonatomic,strong) NSString *missionStatement;
@property (nonatomic,strong) NSString *bio;
@property (nonatomic,strong) NSArray *benefits;
@property (nonatomic,strong) NSURL *webUrl;

@end
