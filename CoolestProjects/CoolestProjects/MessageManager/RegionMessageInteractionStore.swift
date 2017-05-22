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
        loadRegionInteractionsFromDisk()
    }

    fileprivate func regionInteractionsStoreUrl() -> URL? {
        if let dataDirectoryUrl = dataDirectoryUrl() {
            return dataDirectoryUrl.appendingPathComponent(RegionMessageInteractionStoreImpl.storeFileName)
        } else {
            return nil
        }
    }

    fileprivate func loadRegionInteractionsFromDisk() {
        guard
            let storeUrl = regionInteractionsStoreUrl(),
            let data = try? Data(contentsOf: storeUrl)
            else { return }

        do {
            let json = try JSONSerialization.jsonObject(with: data) as! [JSON]
            let storedInteractions = [RegionMessageInteraction].from(jsonArray: json)!
            inMemoryRegionInteractions = storedInteractions
        } catch let error {
            print(error)
        }
    }

    fileprivate func saveRegionInteractionsToDisk(_ interactions: [RegionMessageInteraction]) {
        guard let storeUrl = regionInteractionsStoreUrl(),
            let jsonArray = interactions.toJSONArray()
            else { return }

        do {
            let data = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
            try data.write(to: storeUrl, options: NSData.WritingOptions.atomic)
        } catch let error {
            print(error)
        }
    }

    fileprivate var inMemoryRegionInteractions: [RegionMessageInteraction] = []

    fileprivate static let storeFileName = "regionMessageInteractions.json"

}

extension RegionMessageInteractionStoreImpl: RegionMessageInteractionStore {

    func allInteractions() -> [RegionMessageInteraction] {
        return inMemoryRegionInteractions
    }

    func lastInteractionWithRegion(_ regionId: String) -> RegionMessageInteraction? {
        return inMemoryRegionInteractions.filter { $0.regionId == regionId }.first
    }

    func lastMessageVersionIdWithRegion(_ regionId: String) -> String? {
        return lastInteractionWithRegion(regionId)?.messageVersionId
    }

    func setInteractionWithRegion(_ regionId: String, messageVersionId: String) {
        let ri = RegionMessageInteraction(regionId: regionId, messageVersionId: messageVersionId)
        inMemoryRegionInteractions = inMemoryRegionInteractions.filter { $0.regionId != regionId }
        inMemoryRegionInteractions.append(ri)
        saveRegionInteractionsToDisk(inMemoryRegionInteractions)
    }

}

extension RegionMessageInteractionStoreImpl: DataStore {

}
