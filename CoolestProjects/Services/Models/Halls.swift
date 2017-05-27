//
//  Halls.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 25/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation

struct Hall {
    let id: String
    let name: String
    let panels: [Panel]
    let workshops1: [Workshop]
    let workshops2: [Workshop]
}

struct Panel {
    let name: String
    let description: String
    let startTime: String
    let endTime: String
    let speakers: [Speaker]
}

struct Workshop {
    let name: String
    let description: String
    let startTime: String
    let endTime: String
}

struct Speaker {
    let name: String
    let title: String
    let photoUrl: String?
}
