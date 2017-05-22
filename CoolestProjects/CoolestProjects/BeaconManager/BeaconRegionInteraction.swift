//
//  BeaconInteraction.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 22/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

enum BeaconRegionAction: String {
    case enter = "enter"
    case exit = "exit"
}

struct BeaconRegionInteraction {

    let uuid: String
    let major: UInt8?
    let minor: UInt8?
    let timestamp: TimeInterval
    let action: BeaconRegionAction

}

extension BeaconRegionInteraction: Decodable {

    init?(json: JSON) {
        guard
            let uuid: String = "uuid" <~~ json,
            let timestamp: TimeInterval = "timestamp" <~~ json,
            let action: BeaconRegionAction = "action" <~~ json
            else { return nil }

        self.uuid = uuid
        self.major = "major" <~~ json
        self.minor = "minor" <~~ json
        self.timestamp = timestamp
        self.action = action
    }
}

extension BeaconRegionInteraction: Glossy {

    func toJSON() -> JSON? {
        return jsonify([
            "uuid" ~~> uuid,
            "major" ~~> major,
            "minor" ~~> minor,
            "timestamp" ~~> timestamp,
            "action" ~~> action
            ])
    }
    
}
