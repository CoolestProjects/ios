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
        return loadFromDisk()
    }
    
    init() {
        createDataDirectoryIfNeeded()
    }
    
    func saveProjects(_ projects: [Project]) {
        saveToDisk(items: projects)
        UserDefaults.standard.set(Date(), forKey: projectsLastUpdateDateKey)
    }

}

extension ProjectsStore: DataStore {
    typealias DataItem = Project

    var storeFileName: String {
        get { return "projectsStore.json" }
    }

}
