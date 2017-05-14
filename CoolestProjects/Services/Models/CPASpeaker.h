//
//  CPASpeaker.h
//  CoolestProjects
//
//  Created by BooRanger on 30/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import "CPAObject.h"

@interface CPASpeaker : CPAObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *speakerDescription;
@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic, copy) NSString *talkTitle;
@property (nonatomic, copy) NSString <Optional> *summit;
@property (nonatomic, copy) NSString *summitTimes;

@end
