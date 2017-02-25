//
//  ProjectsStore.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 10/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import Gloss

let projectsLastUpdateDateKey = "projectsLastUpdateDate"
let cacheExpTimeInterval: TimeInterval = 600 // 10 min

class ProjectsStore {
    
    func lastUpdateDate() -> Date {
        if let date = UserDefaults.standard.object(forKey: projectsLastUpdateDateKey) as? Date {
            return date
        } else {
            return Date.distantPast
        }        
    }
    
    func cacheExpired() -> Bool {
        return abs(lastUpdateDate().timeIntervalSinceNow) > cacheExpTimeInterval        
    }
    
    func readProjects() -> [Project] {
        guard let storeUrl = projectsStoreUrl(), let data = try? Data(contentsOf: storeUrl)
            else { return [] }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as! [JSON]
            let projects = [Project].from(jsonArray: json)!
            return projects
            
        } catch let error {
            print(error)
        }
        
        return []
    }
    
    init() {
        createDataDirectoryIfNeeded()
    }
    
    func saveProjects(_ projects: [Project]) {
        guard let jsonArray = projects.toJSONArray(), let storeUrl = projectsStoreUrl()
            else { return }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
            try data.write(to: storeUrl, options: NSData.WritingOptions.atomic)
            UserDefaults.standard.set(Date(), forKey: projectsLastUpdateDateKey)
            
        } catch let error {
            print(error)
        }
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
    
    func dataDirectoryUrl() -> URL? {
        let directories = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.coderdojo.coolestprojects"
        
        if let applicationSupportDirUrl = directories.first {
            return applicationSupportDirUrl.appendingPathComponent(bundleIdentifier)
        }
        
        return nil
    }
    
    func projectsStoreUrl() -> URL? {
        if let dataDirectoryUrl = dataDirectoryUrl() {
            return dataDirectoryUrl.appendingPathComponent("projectsStore.json")
        }
        
        return nil
    }

}
