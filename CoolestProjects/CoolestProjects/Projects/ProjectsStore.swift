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
let cacheExpTimeInterval: NSTimeInterval = 600 // 10 min

class ProjectsStore {
    
    func lastUpdateDate() -> NSDate {
        if let date = NSUserDefaults.standardUserDefaults().objectForKey(projectsLastUpdateDateKey) as? NSDate {
            return date
        } else {
            return NSDate.distantPast()
        }        
    }
    
    func cacheExpired() -> Bool {
        return abs(lastUpdateDate().timeIntervalSinceNow) > cacheExpTimeInterval        
    }
    
    func readProjects() -> [Project] {
        guard let storeUrl = projectsStoreUrl(), let data = NSData(contentsOfURL: storeUrl)
            else { return [] }
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as! [JSON]
            let projects = [Project].fromJSONArray(json)
            return projects
            
        } catch let error {
            print(error)
        }
        
        return []
    }
    
    init() {
        createDataDirectoryIfNeeded()
    }
    
    func saveProjects(projects: [Project]) {
        guard let jsonArray = projects.toJSONArray(), let storeUrl = projectsStoreUrl()
            else { return }
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(jsonArray, options: .PrettyPrinted)
            data.writeToURL(storeUrl, atomically: true)
            NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: projectsLastUpdateDateKey)
            
        } catch let error {
            print(error)
        }
    }
    
    func createDataDirectoryIfNeeded() {
        if let dataDirectoryUrl = dataDirectoryUrl() {
            let dataDirectoryExists = NSFileManager.defaultManager().fileExistsAtPath(dataDirectoryUrl.path!)
            if  !dataDirectoryExists {
                do {
                    try NSFileManager.defaultManager().createDirectoryAtURL(dataDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
                } catch let error {
                    print(error)
                }
            }
        } else {
            print("Cannot find data directory")
        }
    }
    
    func dataDirectoryUrl() -> NSURL? {
        let directories = NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier ?? "com.coderdojo.coolestprojects"
        
        if let applicationSupportDirUrl = directories.first {
            return applicationSupportDirUrl.URLByAppendingPathComponent(bundleIdentifier)
        }
        
        return nil
    }
    
    func projectsStoreUrl() -> NSURL? {
        if let dataDirectoryUrl = dataDirectoryUrl() {
            return dataDirectoryUrl.URLByAppendingPathComponent("projectsStore.json")
        }
        
        return nil
    }

}
