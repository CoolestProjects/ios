//
//  SponsorTableViewCell.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 04/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class SponsorBoxTableViewCell : UITableViewCell, Configurable {
    typealias ItemType = SponsorBox
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    func configure(withItem item: ItemType) {
        title.text = item.title
        title.textColor = item.textColor
            
        for image in item.images {
            stackView.addArrangedSubview(UIImageView(image: image))
        }                
    }
    
    override func prepareForReuse() {
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
}