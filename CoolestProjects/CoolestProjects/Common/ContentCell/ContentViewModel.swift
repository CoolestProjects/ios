//
//  ContentViewModel.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 21/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class ContentViewModel: Component {
    var componentIdentifier: String  = "contentCell"
    var title: String
    var body: String
    var icon: UIImage?

    required init(title: String, body: String, icon: UIImage?) {
        self.title = title
        self.body = body
        self.icon = icon
    }
    
}
