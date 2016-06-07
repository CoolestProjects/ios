//
//  MapsModel.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation

struct MapsModel: DataContaining {
    var data = [(String, String)]()
    
    init(data: [(String, String)]) {
        self.data = data
    }
}
