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
    let supporterTitle : String
    
    let diamondImages: [UIImage]
    let platinumHigherImages: [UIImage]
    let platinumLowerImages: [UIImage]
    let goldImages: [UIImage]
    let goldLowerImages: [UIImage]
    let supporterImages: [UIImage]
    

    let silverTitle : String?
    let bronzeTitle : String?
    let educationTitle : String?
    
    let silverImages: [UIImage]?
    let bronzeImages: [UIImage]?
    let educationImages: [UIImage]?
    
    init(title: String, diamondTitle: String, platinumTitle: String, goldTitle: String, supporterTitle: String, diamondImages: [UIImage], platinumHigherImages: [UIImage], platinumLowerImages: [UIImage], goldImages: [UIImage], goldLowerImages: [UIImage], supporterImages: [UIImage], silverTitle: String? = "", bronzeTitle: String? = "", educationTitle : String? = "", silverImages : [UIImage] = [], bronzeImages : [UIImage] = [], educationImages : [UIImage] = []) {
        
        self.title = title
        self.diamondTitle = diamondTitle
        self.platinumTitle = platinumTitle
        self.goldTitle = goldTitle
        self.supporterTitle = supporterTitle
        
        self.diamondImages = diamondImages
        self.platinumHigherImages = platinumHigherImages
        self.platinumLowerImages = platinumLowerImages
        self.goldImages = goldImages
        self.goldLowerImages = goldLowerImages
        self.supporterImages = supporterImages
        
        self.silverTitle = silverTitle
        self.bronzeTitle = bronzeTitle
        self.educationTitle = educationTitle
        self.bronzeImages = bronzeImages
        self.silverImages = silverImages
        self.educationImages = educationImages
    }

    
    
}

struct BluetoothBox: Component {
    let componentIdentifier = "bluetoothBox"
    let title : String
    let body : String
    let buttonTitle : String
}
