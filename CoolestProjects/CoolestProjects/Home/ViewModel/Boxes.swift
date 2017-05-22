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
    let diamondImages: [UIImage]
    let platinumHigherImages: [UIImage]
    let platinumLowerImages: [UIImage]
    let goldImages: [UIImage]

    init(title: String, diamondImages: [UIImage], platinumHigherImages: [UIImage], platinumLowerImages: [UIImage], goldImages: [UIImage]) {
        self.componentIdentifier = "sponsorBox"
        self.title = title
        self.diamondImages = diamondImages
        self.platinumHigherImages = platinumHigherImages
        self.platinumLowerImages = platinumLowerImages
        self.goldImages = goldImages

    }
}
