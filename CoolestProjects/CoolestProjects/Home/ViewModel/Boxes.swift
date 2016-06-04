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

class InfoBox: Component {
    var componentIdentifier: String
    let title: String
    let body: String
    let textColor: UIColor
    let overlayColor: UIColor
    let backgroundImage: UIImage?    
    
    init(title: String, body: String, textColor: UIColor, overlayColor: UIColor, backgroundImage: UIImage? = nil) {
        self.componentIdentifier = "infoBox"
        self.title = title
        self.body = body
        self.textColor = textColor
        self.overlayColor = overlayColor
        self.backgroundImage = backgroundImage
    }
    
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
