//
//  CPASponsorTier.h
//  CoolestProjects
//
//  Created by BooRanger on 30/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import "CPAObject.h"
#import "CPASponsor.h"

@interface CPASponsorTier : CPAObject

@property (nonatomic, strong) NSArray<CPASponsor> *sponsors;
@property (nonatomic, copy) NSString *tier; //TODO: enum?

@end
