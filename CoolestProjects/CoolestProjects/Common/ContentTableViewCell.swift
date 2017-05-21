//
//  ContentTableViewCell.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 21/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell, Configurable {
    typealias ItemType = ContentViewModel

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var view: UIView!
    
    func configure(with item: ContentViewModel) {
        self.iconImage.image = item.icon
        self.title.text = item.title
        self.body.text = item.body
    }
    
    override func prepareForReuse() {
        iconImage.image = nil
    }
    
}
