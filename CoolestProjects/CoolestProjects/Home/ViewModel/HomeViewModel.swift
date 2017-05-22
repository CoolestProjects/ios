//
//  HomeViewModel.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 01/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel {
    
    let headerBody: String
    
    var tableViewData = [Component]()
    
    init() {
        headerBody = NSLocalizedString("header.body", tableName: "Home", comment: "")
        
        tableViewData = [
            ContentViewModel(
                title: NSLocalizedString("event-times.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("event-times.body", tableName: "Home", comment: ""),
                icon: UIImage(named: "section_icon_event_times")
            ),
            ContentViewModel(
                title: NSLocalizedString("parking.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("parking.body", tableName: "Home", comment: ""),
                icon: UIImage(named: "section_icon_parking")
            ),
            ContentViewModel(
                title: NSLocalizedString("food.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("food.body", tableName: "Home", comment: ""),
                icon: UIImage(named: "section_icon_food")
            ),
            SponsorBox(title: NSLocalizedString("sponsor.title", tableName: "Home", comment: ""), diamondImages: [UIImage(named: "sponsor_diamond_intel")!, UIImage(named: "sponsor_diamond_microsoft")!],
                platinumHigherImages: [UIImage(named: "sponsor_platinum_openet")!,UIImage(named: "sponsor_platinum_rte")!,UIImage(named: "sponsor_platinum_mastercard")!,UIImage(named: "sponsor_platinum_boi")!],
                platinumLowerImages: [UIImage(named: "sponsor_platinum_symantec")!,UIImage(named: "sponsor_platinum_riot")!,UIImage(named: "sponsor_platinum_tdl")!,UIImage(named: "sponsor_platinum_folens")!],
                goldImages: [UIImage(named: "sponsor_gold_1_virgin_media")!]
            ),
            ContentViewModel(
                title: NSLocalizedString("opennet.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("opennet.body", tableName: "Home", comment: ""),
                icon: nil
            )
        ]
    }    
}
