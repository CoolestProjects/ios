//
//  CPASponsorTier.m
//  CoolestProjects
//
//  Created by BooRanger on 30/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import "CPASponsorTier.h"

@implementation CPASponsorTier

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"sponsorList": @"sponsors"
    }];
}
@end
