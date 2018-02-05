//
//  DataStore.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

protocol DataStore {
    associatedtype DataItem

    var storeFileName: String { get }

    func createDataDirectoryIfNeeded()

    func loadFromDisk() -> [DataItem]

    func saveToDisk(items: [DataItem])

}

extension DataStore where DataItem: Glossy {

    func createDataDirectoryIfNeeded() {
        if let dataDirectoryUrl = dataDirectoryUrl() {
            let dataDirectoryExists = FileManager.default.fileExists(atPath: dataDirectoryUrl.path)
            if  !dataDirectoryExists {
                do {
                    try FileManager.default.createDirectory(at: dataDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
                } catch let error {
                    print(error)
                }
            }
        } else {
            print("Cannot find data directory")
        }
    }

    func loadFromDisk() -> [DataItem] {
        guard
            let storeUrl = storeUrl(),
            let data = try? Data(contentsOf: storeUrl)
            else { return [] }

        do {
            let json = try JSONSerialization.jsonObject(with: data) as! [JSON]
            let items = [DataItem].from(jsonArray: json)!
            return items
        } catch let error {
            print(error)
            return []
        }
    }

    func saveToDisk(items: [DataItem]) {
        guard let storeUrl = storeUrl(),
            let jsonArray = items.toJSONArray()
            else { return }

        do {
            let data = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
            try data.write(to: storeUrl, options: NSData.WritingOptions.atomic)
        } catch let error {
            print(error)
        }
    }

    fileprivate func dataDirectoryUrl() -> URL? {
        let directories = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.coderdojo.coolestprojects"

        if let applicationSupportDirUrl = directories.first {
            return applicationSupportDirUrl.appendingPathComponent(bundleIdentifier)
        }

        return nil
    }

    fileprivate func storeUrl() -> URL? {
        if let dataDirectoryUrl = dataDirectoryUrl() {
            return dataDirectoryUrl.appendingPathComponent(storeFileName)
        } else {
            return nil
        }
    }
    
}
