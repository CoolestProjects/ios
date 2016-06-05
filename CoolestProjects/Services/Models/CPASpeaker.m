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
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"description": @"speakerDescription"
    }];
}

- (void)setSummitTimesWithNSString:(NSString *)string {
    self.summitTimes = nil;
    
}

//TODO: remove when model is more stable. 
+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}


@end
