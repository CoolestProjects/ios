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
@class CPAAbout;
@class CPARegion;


/**
 Callback used for the result of the /messages.json call

 @param messages List of messages
 @param error error object
 */
typedef void(^CPAServiceGetBeaconMessagesCompletion)(NSArray<CPARegion *> * _Nullable messages, NSError * _Nullable error);

@protocol CPAFirebaseService <NSObject>

/**
 *  Gets a list of the speakers.
 */
- (void)getSpeakersWithCompletionBlock:(nullable void(^)(NSArray<CPASpeaker *> * _Nullable speakers, NSError * _Nullable error))completionBlock;

/**
 *  Gets the stages that list of speakers speaking on that stag.
 */
- (void)getSummitsWithCompletionBlock:(nullable void(^)(NSArray<CPASummit *> * _Nullable summits, NSError * _Nullable error))completionBlock;

/**
 *  Get a list of the tier and sponsors for that tier.
 */
- (void)getSponsorsWithCompletionBlock:(nullable void(^)(NSArray<CPASponsorTier *> * _Nullable sponsorTiers, NSError * _Nullable error))completionBlock;


- (void)getAboutInfoWithCompletionBlock:(nullable void(^)(CPAAbout * _Nullable aboutContent, NSError * _Nullable error))completionBlock;

- (void)getVenueInfoWithCompletionBlock:(nullable void(^)(id _Nullable venue, NSError * _Nullable error))completionBlock;

/**
 *  Get a list of the tier and sponsors for that tier.
 */
- (void)getRegionsWithCompletionBlock:(nullable void(^)(NSArray<CPARegion *> * _Nullable regions, NSError * _Nullable error))completionBlock
NS_SWIFT_NAME(getRegions(_:));


/**
 Fetches all the messages defined for all the beacon regions
 
 /messages.json

 @param completionBlock List of messages or error object
 */
- (void)getBeaconMessagesWithCompletionBlock:(nullable CPAServiceGetBeaconMessagesCompletion)completionBlock NS_SWIFT_NAME(getBeaconMessages(_:));

@end
