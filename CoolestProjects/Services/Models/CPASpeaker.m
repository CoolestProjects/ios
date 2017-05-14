//
//  CPASpeaker.m
//  CoolestProjects
//
//  Created by BooRanger on 30/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import "CPASpeaker.h"

@implementation CPASpeaker

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"speakerDescription": @"description"}];
}

@end
