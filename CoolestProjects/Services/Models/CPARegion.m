//
//  CPARegion.m
//  CoolestProjects
//
//  Created by Rich on 16/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

#import "CPARegion.h"

@implementation CPARegion

- (instancetype)init {
    self = [super init];
    if (self) {
        self.regionId = @"";
        self.beacons = (NSArray<CPABeacon *><CPABeacon> *)@[];
    }
    return self;
}

@end
