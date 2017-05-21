//
//  InfoBox.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 02/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

protocol Component {
    var componentIdentifier: String { get }
}

class SponsorBox: Component {
    var componentIdentifier: String
    let title: String
    let textColor: UIColor
    let images: [UIImage]
    
    init(title: String, textColor: UIColor, images: [UIImage]) {
        self.componentIdentifier = "sponsorBox"
        self.title = title
        self.textColor = textColor
        self.images = images
    }
}
