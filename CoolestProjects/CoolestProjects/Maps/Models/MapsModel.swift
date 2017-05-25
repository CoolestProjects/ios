//
//  MapsModel.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation

struct MapsModel: Component {
    var data = [(title: String, mapUrl: String)]()
    var componentIdentifier: String = "MapViewCell"

    init(data: [(title: String, mapUrl: String)]) {
        self.data = data
    }
}

class MaapViewModel {
    
    var tableViewData = [Component]()
    
    init() {
        tableViewData = [
            BlurbBox(title: NSLocalizedString("date.tilte", tableName: "Home", comment: "")),
            MapsModel(data: [(title: NSLocalizedString("map.rds", tableName: "Maps", comment: ""), mapUrl: "https://firebasestorage.googleapis.com/v0/b/coolestprojectsapp.appspot.com/o/Maps%2Fcoolestprojectsmap.png?alt=media&token=cf6515dd-9947-4595-a203-422c6427a2ca")])
        ]
    }    
}
