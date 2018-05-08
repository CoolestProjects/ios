//
//  Array+Gloss.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Gloss

extension Array where Element: Gloss.Decodable {

    static func partialFrom(jsonArray: [JSON]) -> [Element] {
        var models: [Element] = []

        for json in jsonArray {
            let model = Element(json: json)

            if let model = model {
                models.append(model)
            } else {
                print("Cannot decode json object \(json)")
            }
        }

        return models
    }

}
