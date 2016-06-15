//
//  CPAFirebaseDefaultService.m
//  CoolestProjects
//
//  Created by BooRanger on 30/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import "CPAFirebaseDefaultService.h"
#import "CPASpeaker.h"
#import "CPASummit.h"
#import "CPASponsorTier.h"
#import "CPAAbout.h"

@import Firebase;

NSString *const CPADatabaseChildSpeakers = @"speakers";
NSString *const CPADatabaseChildSummits = @"summits";
NSString *const CPADatabaseChildSponsors = @"sponsors";
NSString *const CPADatabaseChildVenue = @"venue";
NSString *const CPADatabaseChildAbout = @"about";

@interface CPAFirebaseDefaultService ()

@property (nonatomic, strong) FIRDatabaseReference *firebaseDatabase;

@end

@implementation CPAFirebaseDefaultService

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.firebaseDatabase = [[FIRDatabase database] reference];
}

- (void)getSpeakersWithCompletionBlock:(void(^)(NSArray<CPASpeaker *> *speakers, NSError *error))completionBlock {

    [self getDataForChild:CPADatabaseChildSpeakers withCompletionBlock:^(id results, NSError *error) {
        NSMutableArray *speakers = [NSMutableArray array];
        for (NSDictionary *dict in results) {
            CPASpeaker *speaker = [[CPASpeaker alloc] initWithDictionary:dict error:NULL];
            if (speaker) {
                [speakers addObject:speaker];
            }
        }
        
        if (completionBlock) {
            completionBlock(speakers, error);
        }
    }];
}

- (void)getSummitsWithCompletionBlock:(void(^)(NSArray<CPASummit *> *summits, NSError *error))completionBlock {

    [self getDataForChild:CPADatabaseChildSummits withCompletionBlock:^(id results, NSError *error) {
        NSMutableArray *summits = [NSMutableArray array];
        for (NSDictionary *dict in results) {
            CPASummit *summit = [[CPASummit alloc] initWithDictionary:dict error:NULL];
            if (summit) {
                [summits addObject:summit];
            }
        }

        if (completionBlock) {
            completionBlock(summits, error);
        }
    }];
}

- (void)getSponsorsWithCompletionBlock:(void(^)(NSArray<CPASponsorTier *> *sponsorTiers, NSError *error))completionBlock {

    [self getDataForChild:CPADatabaseChildSponsors withCompletionBlock:^(id results, NSError *error) {
        NSMutableArray *sponsorTiers = [NSMutableArray array];
        for (NSDictionary *dict in results) {
            CPASponsorTier *sponsorsTier = [[CPASponsorTier alloc] initWithDictionary:dict error:NULL];
            if (sponsorsTier) {
                [sponsorTiers addObject:sponsorsTier];
            }            
        }

        if (completionBlock) {
            completionBlock(sponsorTiers, error);
        }
    }];
}

- (void)getVenueInfoWithCompletionBlock:(void(^)(id venue, NSError *error))completionBlock {
    
    // TODO: do we need this endpoint?
    if (completionBlock) {
        completionBlock(nil, [NSError errorWithDomain:@"org.coolestprojects.coolestprojectsevent" code:1000 userInfo:nil]);
    }
}

- (void)getAboutInfoWithCompletionBlock:(nullable void(^)(CPAAbout * _Nullable aboutContent, NSError * _Nullable error))completionBlock {
    
    [self getDataForChild:CPADatabaseChildAbout withCompletionBlock:^(id results, NSError *error) {
        CPAAbout *about;
        
        if (!error) {
            // TODO: handle parsing errors
            about = [[CPAAbout alloc] initWithDictionary:results error:nil];
        }
        
        if (completionBlock) {
            completionBlock(about, error);
        }
        
    }];
}

- (void)getDataForChild:(NSString *)child withCompletionBlock:(void(^)(id results, NSError *error))completionBlock {
    [[self.firebaseDatabase child:child] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completionBlock(snapshot.value, nil);
    } withCancelBlock:^(NSError * _Nonnull error) {
        completionBlock(@[], error);
    }];
}

@end
