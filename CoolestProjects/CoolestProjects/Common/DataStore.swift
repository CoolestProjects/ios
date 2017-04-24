//
//  DataStore.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation

protocol DataStore {

    func dataDirectoryUrl() -> URL?

    func createDataDirectoryIfNeeded()

}

extension DataStore {

    func dataDirectoryUrl() -> URL? {
        let directories = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.coderdojo.coolestprojects"

        if let applicationSupportDirUrl = directories.first {
            return applicationSupportDirUrl.appendingPathComponent(bundleIdentifier)
        }

        return nil
    }

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
    
}
