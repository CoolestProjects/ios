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
    
    let headerTitle: String
    let headerBody: String
    
    var tableViewData = [Component]()
    
    init() {
        headerTitle = NSLocalizedString("header.title", tableName: "Home", comment: "")
        headerBody = NSLocalizedString("header.body", tableName: "Home", comment: "")
        
        tableViewData = [
            SponsorBox(
                title: NSLocalizedString("sponsor.title", tableName: "Home", comment: ""),
                textColor: AppColors.darkTextColor,
                images: [UIImage(named: "sponsor-aol")!, UIImage(named: "sponsor-microsoft")!, UIImage(named: "sponsor-intel")!]
            ),
            InfoBox(
                title: NSLocalizedString("event-times.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("event-times.body", tableName: "Home", comment: ""),
                textColor: AppColors.darkTextColor,
                overlayColor: AppColors.redColor),
            InfoBox(
                title: NSLocalizedString("parking.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("parking.body", tableName: "Home", comment: ""),
                textColor: AppColors.lightTextColor,
                overlayColor: AppColors.darkOverlayColor,
                backgroundImage: UIImage(named: "coderdojo-image01")
            ),
            InfoBox(
                title: NSLocalizedString("food.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("food.body", tableName: "Home", comment: ""),
                textColor: AppColors.darkTextColor,
                overlayColor: AppColors.yellowColor),
            InfoBox(
                title: NSLocalizedString("opennet.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("opennet.body", tableName: "Home", comment: ""),
                textColor: AppColors.darkTextColor,
                overlayColor: AppColors.blueColor),
        ]
    }    
}