//
//  MapsModel.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation

struct MapsModel: Component {
//    var data = [(title: String, mapUrl: String)]()
    var componentIdentifier: String = "MapViewCell"
    var title: String
    var mapUrl: String
    init(title: String, mapUrl: String) {
        self.title = title
        self.mapUrl = mapUrl
    }
}

class MapViewModel {
    
    var tableViewData = [Component]()
    let title: String
    
    init() {

        title = NSLocalizedString("title", tableName: "Maps", comment: "")
        
        tableViewData = [
            BlurbBox(title: NSLocalizedString("date.title", tableName: "Home", comment: "")),
            MapsModel(title: NSLocalizedString("map.rds", tableName: "Maps", comment: ""), mapUrl: "https://firebasestorage.googleapis.com/v0/b/coolestprojectsapp.appspot.com/o/Maps%2Fcoolestprojectsmap.png?alt=media&token=cf6515dd-9947-4595-a203-422c6427a2ca")
        ]
    }    
}
