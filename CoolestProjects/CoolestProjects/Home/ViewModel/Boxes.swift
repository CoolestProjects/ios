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

class BluetoothBox: Component {
    let componentIdentifier = "bluetoothBox"
    let bluetoothTitle = "MY GEMS"
    let bluetoothBody = "Let’s play and find a Gem! Use your Mobile Phone as Gem detector. You will receive a notification every time youfind the location of a Gem. \n\nMake sure you go alongside with your parents."
}
