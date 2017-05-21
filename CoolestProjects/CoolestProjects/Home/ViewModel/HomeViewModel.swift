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
            SponsorBox(
                title: NSLocalizedString("sponsor.title", tableName: "Home", comment: ""),
                textColor: AppColors.darkTextColor,
                images: []
            ),
            ContentViewModel(
                title: NSLocalizedString("opennet.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("opennet.body", tableName: "Home", comment: ""),
                icon: nil
            )
        ]
    }    
}
