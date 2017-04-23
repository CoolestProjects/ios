//
//  CPAMessage.m
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

#import "CPAMessage.h"

@implementation CPAMessage

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"";
        self.message = @"";
        self.regionId = @"";
        self.versionId = @"";
    }
    return self;
}

@end
