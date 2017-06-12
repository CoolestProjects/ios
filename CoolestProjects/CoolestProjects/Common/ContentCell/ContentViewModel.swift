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
    var ctaText: String?

    required init(title: String, body: String, icon: UIImage?, ctaText: String?) {
        self.title = title
        self.body = body
        self.icon = icon
        self.ctaText = ctaText
    }
    
}

extension ContentViewModel {

    convenience init(hall: Hall) {
        self.init(
            title: hall.name,
            body: hall.description,
            icon: UIImage(named: ""),
            ctaText: NSLocalizedString("contentBox.cta", tableName: "Halls", comment: "See all activities"))
    }

}
