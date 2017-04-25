//
//  RegionInteractionStore.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

protocol RegionInteractionStore {

    func allInteractions() -> [RegionInteraction]

    func lastInteractionWithRegion(_ regionId: String) -> RegionInteraction?

    func lastMessageVersionIdWithRegion(_ regionId: String) -> String?

    func setInteractionWithRegion(_ regionId: String, messageVersionId: String)

}

class RegionInteractionStoreImpl {

    init() {
        createDataDirectoryIfNeeded()
        loadRegionInteractionsFromDisk()
    }

    fileprivate func regionInteractionsStoreUrl() -> URL? {
        if let dataDirectoryUrl = dataDirectoryUrl() {
            return dataDirectoryUrl.appendingPathComponent(RegionInteractionStoreImpl.storeFileName)
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
            let storedInteractions = [RegionInteraction].from(jsonArray: json)!
            inMemoryRegionInteractions = storedInteractions
        } catch let error {
            print(error)
        }
    }

    fileprivate func saveRegionInteractionsToDisk(_ interactions: [RegionInteraction]) {
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

    fileprivate var inMemoryRegionInteractions: [RegionInteraction] = []

    fileprivate static let storeFileName = "regionInteractions.json"

}

extension RegionInteractionStoreImpl: RegionInteractionStore {

    func allInteractions() -> [RegionInteraction] {
        return inMemoryRegionInteractions
    }

    func lastInteractionWithRegion(_ regionId: String) -> RegionInteraction? {
        return inMemoryRegionInteractions.filter { $0.regionId == regionId }.first
    }

    func lastMessageVersionIdWithRegion(_ regionId: String) -> String? {
        return lastInteractionWithRegion(regionId)?.messageVersionId
    }

    func setInteractionWithRegion(_ regionId: String, messageVersionId: String) {
        let ri = RegionInteraction(regionId: regionId, messageVersionId: messageVersionId)
        inMemoryRegionInteractions = inMemoryRegionInteractions.filter { $0.regionId != regionId }
        inMemoryRegionInteractions.append(ri)
        saveRegionInteractionsToDisk(inMemoryRegionInteractions)
    }

}

extension RegionInteractionStoreImpl: DataStore {

}
