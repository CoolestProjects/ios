//
//  BlurbTableViewCell.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 23/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class BlurbTableViewCell: UITableViewCell, Configurable {
    typealias ItemType = BlurbBox


    @IBOutlet weak var title: UILabel!

    func configure(with item: BlurbBox) {
        title.text = item.title
    }
    
}
