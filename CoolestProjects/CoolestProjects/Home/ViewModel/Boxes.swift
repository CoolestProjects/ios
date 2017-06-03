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

struct SponsorBox: Component {
    let componentIdentifier = "sponsorBox"
    let title: String
    
    let diamondTitle : String
    let platinumTitle : String
    let goldTitle : String
    
    let diamondImages: [UIImage]
    let platinumHigherImages: [UIImage]
    let platinumLowerImages: [UIImage]
    let goldImages: [UIImage]
    let goldLowerImages: [UIImage]
}

struct BluetoothBox: Component {
    let componentIdentifier = "bluetoothBox"
    let title : String
    let body : String
    let buttonTitle : String
}
