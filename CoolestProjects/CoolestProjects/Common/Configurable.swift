//
//  Configurable.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 04/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation

protocol Configurable {
    associatedtype ItemType
    func configure(withItem item: ItemType)
}