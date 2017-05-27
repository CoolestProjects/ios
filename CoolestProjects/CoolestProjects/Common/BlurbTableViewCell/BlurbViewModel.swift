//
//  BlurbViewModel.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 25/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit


class BlurbBox: Component {
    var componentIdentifier: String
    let title: String
    
    init(title: String) {
        self.componentIdentifier = "blurbCell"
        self.title = title
    }
}
