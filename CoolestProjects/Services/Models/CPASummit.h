//
// Created by BooRanger on 30/05/2016.
// Copyright (c) 2016 coderdojo. All rights reserved.
//

#import "CPAObject.h"

@protocol CPASpeaker;

@interface CPASummit : CPAObject

@property (nonatomic, strong) NSArray<CPASpeaker> *speakers;
@property (nonatomic, copy) NSString *name;

@end

@interface CPASummitTime : CPAObject

@property (nonatomic, copy) NSString<Optional> *time;
@property (nonatomic, strong) NSNumber<Optional> *timestamp;

@end