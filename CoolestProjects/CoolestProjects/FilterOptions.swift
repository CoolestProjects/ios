//
//  FilterOptions.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation

struct FilterOption {
    let name: String
    var selected: Bool
}

struct FilterOptionGroup {
    let category: String
    var options: [FilterOption]
}