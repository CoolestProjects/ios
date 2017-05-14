//
// Created by BooRanger on 30/05/2016.
// Copyright (c) 2016 coderdojo. All rights reserved.
//

#import "CPASponsor.h"

@implementation CPASponsor

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"sponsorDescription": @"description"}];
}

@end
