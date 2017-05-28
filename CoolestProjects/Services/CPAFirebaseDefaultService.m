//
//  CPAFirebaseDefaultService.m
//  CoolestProjects
//
//  Created by BooRanger on 30/05/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

#import "CPAFirebaseDefaultService.h"
#import "CPASponsorTier.h"
#import "CPAAbout.h"
#import "CPARegion.h"

@import Firebase;

NSString *const CPADatabaseChildSponsors = @"sponsors";
NSString *const CPADatabaseChildAbout = @"about";
NSString *const CPADatabaseChildRegions = @"regions";

@interface CPAFirebaseDefaultService ()

@property (nonatomic, strong) FIRDatabaseReference *firebaseDatabase;
@property (nonatomic, strong) FIRDatabaseReference *sponsorsRef;
@property (nonatomic, strong) FIRDatabaseReference *aboutRef;
@property (nonatomic, strong) FIRDatabaseReference *regionsRef;

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

    self.sponsorsRef = [self.firebaseDatabase child:CPADatabaseChildSponsors];
    [self.sponsorsRef keepSynced:YES];

    self.aboutRef = [self.firebaseDatabase child:CPADatabaseChildAbout];
    [self.aboutRef keepSynced:YES];

    self.regionsRef = [self.firebaseDatabase child:CPADatabaseChildRegions];
    [self.regionsRef keepSynced:YES];
}

- (void)getSponsorsWithCompletionBlock:(void(^)(NSArray<CPASponsorTier *> *sponsorTiers, NSError *error))completionBlock {
    [self getSnapshotFromDataRef:self.sponsorsRef withTransform:^id(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableArray *sponsorTiers = [NSMutableArray array];
        for (NSDictionary *dict in snapshot.value) {
            NSError *jsonError;
            CPASponsorTier *sponsorsTier = [[CPASponsorTier alloc] initWithDictionary:dict error:&jsonError];
            if (sponsorsTier) {
                [sponsorTiers addObject:sponsorsTier];
            } else if (jsonError) {
                NSLog(@"Cannot initialise CPASponsorTier object with data: %@. Error: %@", dict, jsonError);
            }
        }
        return sponsorTiers;
    } completionBlock:^(id _Nullable data, NSError * _Nullable error) {
        if (completionBlock) {
            completionBlock(data, error);
        }
    }];
}

- (void)getAboutInfoWithCompletionBlock:(nullable void(^)(CPAAbout * _Nullable aboutContent, NSError * _Nullable error))completionBlock {
    [self getSnapshotFromDataRef:self.aboutRef withTransform:^id(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *dict = snapshot.value;
        NSError *jsonError;
        CPAAbout *about = [[CPAAbout alloc] initWithDictionary:dict error:&jsonError];
        if (jsonError) {
            NSLog(@"Cannot initialise CPAAbout object with data: %@. Error: %@", dict, jsonError);
        }
        return about;
    } completionBlock:^(id _Nullable data, NSError * _Nullable error) {
        if (completionBlock) {
            completionBlock(data, error);
        }
    }];
}

- (void)getRegionsWithCompletionBlock:(void (^)(NSArray<CPARegion *> * _Nullable, NSError * _Nullable))completionBlock {
    [self getSnapshotFromDataRef:self.regionsRef withTransform:^id(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableArray *regions = [NSMutableArray array];
        for (NSDictionary *dict in snapshot.value) {
            NSError *jsonError;
            CPARegion *region = [[CPARegion alloc] initWithDictionary:dict error:&jsonError];
            if (region) {
                [regions addObject:region];
            } else if (jsonError) {
                NSLog(@"Cannot initialise CPARegion object with data: %@. Error: %@", dict, jsonError);
            }
        }
        return regions;
    } completionBlock:^(id _Nullable data, NSError * _Nullable error) {
        if (completionBlock) {
            completionBlock(data, error);
        }
    }];
}

- (void)getSnapshotFromDataRef:(nonnull FIRDatabaseReference *)dataRef
                 withTransform:(nonnull id(^)(FIRDataSnapshot * _Nonnull snapshot))tranform
           completionBlock:(nonnull void(^)(id _Nullable data, NSError * _Nullable error))completionBlock {
    [dataRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        id data = tranform(snapshot);
        completionBlock(data, nil);
    } withCancelBlock:^(NSError * _Nonnull error) {
        completionBlock(nil, error);
    }];

}

@end
