//
//  CPAFirebaseService.h
//  CoolestProjects
//
//  Created by BooRanger on 30/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPASpeaker;
@class CPASummit;
@class CPASponsorTier;

@protocol CPAFirebaseService <NSObject>

/**
 *  Gets a list of the speakers.
 */
- (void)getSpeakersWithCompletionBlock:(void(^)(NSArray<CPASpeaker *> *speakers, NSError *error))completionBlock;

/**
 *  Gets the stages that list of speakers speaking on that stag.
 */
- (void)getSummitsWithCompletionBlock:(void(^)(NSArray<CPASummit *> *summits, NSError *error))completionBlock;

/**
 *  Get a list of the tier and sponsors for that tier.
 */
- (void)getSponsorsWithCompletionBlock:(void(^)(NSArray<CPASponsorTier *> *sponsorTiers, NSError *error))completionBlock;
- (void)getVenueInfoWithCompletionBlock:(void(^)(id *venue, NSError *error))completionBlock;

@end
