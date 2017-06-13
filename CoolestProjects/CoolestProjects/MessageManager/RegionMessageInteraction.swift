//
//  RegionInteraction.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

struct RegionMessageInteraction {

    let regionId: String
    let messageVersionId: String
    let timestamp: TimeInterval
    let title: String
    let message: String

    init(regionId: String, messageVersionId: String, timestamp: TimeInterval, title: String, message: String) {
        self.regionId = regionId
        self.messageVersionId = messageVersionId
        self.timestamp = timestamp
        self.title = title
        self.message = message
    }

    init(regionId: String, messageVersionId: String) {
        self.init(regionId: regionId, messageVersionId: messageVersionId, timestamp: Date().timeIntervalSince1970 * 1000, title:"", message:"")
    }
    
    init(regionId: String, messageVersionId: String, title: String, message: String) {
        self.init(regionId: regionId, messageVersionId: messageVersionId, timestamp: Date().timeIntervalSince1970 * 1000, title: title, message: message)
    }
}

extension RegionMessageInteraction: Equatable {}
func ==(lhs: RegionMessageInteraction, rhs: RegionMessageInteraction) -> Bool {
    return
        lhs.regionId == rhs.regionId &&
        lhs.messageVersionId == rhs.messageVersionId &&
        lhs.timestamp == rhs.timestamp
}

extension RegionMessageInteraction: Decodable {

    init?(json: JSON) {
        guard
            let regionId: String = "regionId" <~~ json,
            let messageVersionId: String = "messageVersionId" <~~ json,
            let timestamp: TimeInterval = "timestamp" <~~ json,
            let title: String = "title" <~~ json,
            let message: String = "message" <~~ json
            else { return nil }

        self.regionId = regionId
        self.messageVersionId = messageVersionId
        self.timestamp = timestamp
        self.title = title
        self.message = message
    }
}

extension RegionMessageInteraction: Glossy {

    func toJSON() -> JSON? {
        return jsonify([
            "regionId" ~~> regionId,
            "messageVersionId" ~~> messageVersionId,
            "timestamp" ~~> timestamp,
            "title" ~~> title,
            "message" ~~> message
            ])
    }

}
