//
//  WorkshopTableViewCell.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 27/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class WorkshopTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = UIColor.battleshipGrey
        timeLabel.textColor = UIColor.battleshipGrey
        descriptionLabel.textColor = UIColor.battleshipGrey
    }

}

extension WorkshopTableViewCell: Configurable {
    typealias ItemType = Workshop

    func configure(with item: ItemType) {
        titleLabel.text = item.name.uppercased()
        timeLabel.text = "\(item.startTime) - \(item.endTime)"
        descriptionLabel.text = item.description
    }
}
