//
//  CPABeacon.h
//  CoolestProjects
//
//  Created by Rich on 16/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

#import "CPAObject.h"

@protocol CPABeacon;

NS_ASSUME_NONNULL_BEGIN

@interface CPABeacon : CPAObject

@property(nonatomic, strong) NSNumber *major;
@property(nonatomic, strong) NSNumber *minor;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *uuid;

@end

NS_ASSUME_NONNULL_END
