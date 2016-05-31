//
// Created by BooRanger on 30/05/2016.
// Copyright (c) 2016 coderdojo. All rights reserved.
//

#import "CPASummit.h"


@implementation CPASummit

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
         @"summit": @"name"
    }];
}

@end