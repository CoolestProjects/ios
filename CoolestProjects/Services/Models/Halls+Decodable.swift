//
//  Halls+Gloss.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 25/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

extension Hall: Decodable {

    init?(json: JSON) {
        guard let id: String = "hallId" <~~ json,
            let name: String = "hall" <~~ json,
            let panels: [Panel] = "hallPanels" <~~ json,
            let workshops1: [Workshop] = "hallWorkshops1" <~~ json,
            let workshops2: [Workshop] = "hallWorkshops2" <~~ json
            else { return nil }

        self.id = id
        self.name = name
        self.panels = panels
        self.workshops1 = workshops1
        self.workshops2 = workshops2
    }

}

extension Panel: Decodable {

    init?(json: JSON) {
        guard let name: String = "name" <~~ json,
            let description: String = "description" <~~ json,
            let startTime: String = "startTime" <~~ json,
            let endTime: String = "endTime" <~~ json,
            let speakers: [Speaker] = "panelSpeakers" <~~ json
            else { return nil }

        self.name = name
        self.description = description
        self.startTime = startTime
        self.endTime = endTime
        self.speakers = speakers
    }

}

extension Workshop: Decodable {

    init?(json: JSON) {
        guard let name: String = "name" <~~ json,
            let description: String = "description" <~~ json,
            let startTime: String = "startTime" <~~ json,
            let endTime: String = "endTime" <~~ json
            else { return nil }

        self.name = name
        self.description = description
        self.startTime = startTime
        self.endTime = endTime
    }

}

extension Speaker: Decodable {

    init?(json: JSON) {
        guard let name: String = "name" <~~ json,
            let title: String = "title" <~~ json else { return nil }

        self.name = name
        self.title = title
        self.photoUrl = "photoUrl" <~~ json
    }

}
