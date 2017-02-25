//
// Created by BooRanger on 30/05/2016.
// Copyright (c) 2016 coderdojo. All rights reserved.
//

#import "CPASummit.h"

@implementation CPASummit

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"summit": @"name"}];
}

@end

@implementation CPASummitTime

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"string": @"time"}];
}

@end
