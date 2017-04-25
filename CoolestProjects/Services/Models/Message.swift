//
//  Message.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 24/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

struct Message {
    let title: String
    let message: String
    let regionId: String
    let versionId: String    
}

extension Message: Decodable {

    init?(json: JSON) {
        guard
            let title: String = "title" <~~ json,
            let message: String = "message" <~~ json,
            let regionId: String = "regionId" <~~ json,
            let versionId: String = "versionId" <~~ json
            else { return nil }

        self.title = title
        self.message = message
        self.regionId = regionId
        self.versionId = versionId
    }
}

