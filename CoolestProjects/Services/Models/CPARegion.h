//
//  CPARegion.h
//  CoolestProjects
//
//  Created by Rich on 16/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

#import "CPAObject.h"
#import "CPABeacon.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPARegion : CPAObject

@property (nonatomic, strong) NSArray<CPABeacon *> <CPABeacon> *beacons;
@property (nonatomic, copy) NSString *regionId;

@end

NS_ASSUME_NONNULL_END
