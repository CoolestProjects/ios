//
//  InfoBoxTableViewCell.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 02/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class InfoBoxTableViewCell : UITableViewCell, Configurable {
    typealias ItemType = InfoBox
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    func configure(withItem item: ItemType) {
        backgroundImage.image = item.backgroundImage
        overlayView.backgroundColor = item.overlayColor
        title.text = item.title
        title.textColor = item.textColor
        body.text = item.body
        body.textColor = item.textColor
    }
    
    override func prepareForReuse() {
        backgroundImage.image = nil        
    }
}


