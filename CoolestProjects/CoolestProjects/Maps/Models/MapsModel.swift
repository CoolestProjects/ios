//
//  MapsModel.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation

struct MapsModel: DataContaining {
    var data = [(title: String, mapUrl: String)]()
    
    init(data: [(title: String, mapUrl: String)]) {
        self.data = data
    }
}
