//
//  BeaconInteractionStore.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 22/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import CoreLocation
import Gloss
import FirebaseAnalytics


protocol BeaconRegionInteractionStore {

    func allInteractions() -> [BeaconRegionInteraction]

    func enterBeaconRegion(_ region: CLBeaconRegion)

    func exitBeaconRegion(_ region: CLBeaconRegion)

}

class BeaconRegionInteractionStoreImpl {

    init() {
        createDataDirectoryIfNeeded()
        inMemoryInteractions = loadFromDisk()
    }

    fileprivate var inMemoryInteractions: [BeaconRegionInteraction] = []

}

extension BeaconRegionInteractionStoreImpl: BeaconRegionInteractionStore {

    func allInteractions() -> [BeaconRegionInteraction] {
        return inMemoryInteractions
    }

    func enterBeaconRegion(_ region: CLBeaconRegion) {
        trackBeaconInteraction(event: BeaconAnalyticsEvent.enter.rawValue, regionIdentifier: region.identifier)
        addAndSaveInteraction(with: region, action: .enter)
    }

    func exitBeaconRegion(_ region: CLBeaconRegion) {
        trackBeaconInteraction(event: BeaconAnalyticsEvent.exit.rawValue, regionIdentifier: region.identifier)
        addAndSaveInteraction(with: region, action: .exit)
    }

    fileprivate func addAndSaveInteraction(with region: CLBeaconRegion, action: BeaconRegionAction) {
        let regionInteraction = BeaconRegionInteraction(
            uuid: region.proximityUUID.uuidString,
            major: region.major?.uint8Value,
            minor: region.minor?.uint8Value,
            timestamp: Date().timeIntervalSince1970 * 1000,
            action: action)

        inMemoryInteractions.append(regionInteraction)
        saveToDisk(items: inMemoryInteractions)
    }

    fileprivate func trackBeaconInteraction(event: String, regionIdentifier: String) {
        FIRAnalytics.logEvent(withName: event, parameters: [BeaconAnalyticsProperty.regionId.rawValue: regionIdentifier])
    }

}

extension BeaconRegionInteractionStoreImpl: DataStore {
    typealias DataItem = BeaconRegionInteraction

    var storeFileName: String {
        get { return "beaconRegionInteractions.json" }
    }
    
}
