//
//  RegionInteractionStore.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

protocol RegionMessageInteractionStore {

    func allInteractions() -> [RegionMessageInteraction]

    func lastInteractionWithRegion(_ regionId: String) -> RegionMessageInteraction?

    func lastMessageVersionIdWithRegion(_ regionId: String) -> String?

    func setInteractionWithRegion(_ regionId: String, messageVersionId: String)

}

class RegionMessageInteractionStoreImpl {

    init() {
        createDataDirectoryIfNeeded()
        inMemoryInteractions = loadFromDisk()
    }

    fileprivate var inMemoryInteractions: [RegionMessageInteraction] = []

}

extension RegionMessageInteractionStoreImpl: RegionMessageInteractionStore {

    func allInteractions() -> [RegionMessageInteraction] {
        return inMemoryInteractions
    }

    func lastInteractionWithRegion(_ regionId: String) -> RegionMessageInteraction? {
        return inMemoryInteractions.filter { $0.regionId == regionId }.first
    }

    func lastMessageVersionIdWithRegion(_ regionId: String) -> String? {
        return lastInteractionWithRegion(regionId)?.messageVersionId
    }

    func setInteractionWithRegion(_ regionId: String, messageVersionId: String) {
        let ri = RegionMessageInteraction(regionId: regionId, messageVersionId: messageVersionId)
        inMemoryInteractions = inMemoryInteractions.filter { $0.regionId != regionId }
        inMemoryInteractions.append(ri)
        saveToDisk(items: inMemoryInteractions)
    }

}

extension RegionMessageInteractionStoreImpl: DataStore {
    typealias DataItem = RegionMessageInteraction

    var storeFileName: String {
        get { return "regionMessageInteractions.json" }
    }

}
