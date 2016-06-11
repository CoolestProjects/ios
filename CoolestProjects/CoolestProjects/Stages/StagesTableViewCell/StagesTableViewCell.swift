//
//  StagesTableViewCell.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class StagesTableViewCell : UITableViewCell, Configurable {
    typealias ItemType = CPASpeaker
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var stageTime: UILabel!
    
    
    func configure(withItem item: ItemType) {
        fullName.text = item.name
        role.text = item.speakerDescription
        stageTime.text = item.summitTimesAsString
        
        photo.sd_setImageWithURL(NSURL(string: item.photoUrl), placeholderImage: UIImage(named: "null-avatar"))
    }
    
    override func prepareForReuse() {
        photo?.image = UIImage(named: "null-avatar")
    }
}
