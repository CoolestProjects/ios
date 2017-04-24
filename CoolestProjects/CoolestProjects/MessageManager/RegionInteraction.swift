//
//  RegionInteraction.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

struct RegionInteraction {

    let regionId: String
    let messageVersionId: String
    let timestamp: TimeInterval

    init(regionId: String, messageVersionId: String, timestamp: TimeInterval) {
        self.regionId = regionId
        self.messageVersionId = messageVersionId
        self.timestamp = timestamp
    }

    init(regionId: String, messageVersionId: String) {
        self.init(regionId: regionId, messageVersionId: messageVersionId, timestamp: Date().timeIntervalSince1970 * 1000)
    }
}

extension RegionInteraction: Equatable {}
func ==(lhs: RegionInteraction, rhs: RegionInteraction) -> Bool {
    return
        lhs.regionId == rhs.regionId &&
        lhs.messageVersionId == rhs.messageVersionId &&
        lhs.timestamp == rhs.timestamp
}

extension RegionInteraction: Decodable {

    init?(json: JSON) {
        guard
            let regionId: String = "regionId" <~~ json,
            let messageVersionId: String = "messageVersionId" <~~ json,
            let timestamp: TimeInterval = "timestamp" <~~ json
            else { return nil }

        self.regionId = regionId
        self.messageVersionId = messageVersionId
        self.timestamp = timestamp
    }
}

extension RegionInteraction: Glossy {

    func toJSON() -> JSON? {
        return jsonify([
            "regionId" ~~> regionId,
            "messageVersionId" ~~> messageVersionId,
            "timestamp" ~~> timestamp            
            ])
    }

}
