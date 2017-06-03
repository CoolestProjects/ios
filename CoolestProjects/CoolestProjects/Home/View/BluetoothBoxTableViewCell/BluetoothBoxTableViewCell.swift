//
//  BluetoothBoxTableViewCell.swift
//  CoolestProjects
//
//  Created by Rich on 27/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class BluetoothBoxTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var radarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var viewGemsButton: UIButton!
    //@IBOutlet weak var bottomImageView: UIImageView!
    
    typealias ItemType = BluetoothBox
    
    func configure(with item: ItemType) {
        self.radarImageView?.image = UIImage.animatedImageNamed("beaconAnimation-", duration: 1)
        self.titleLabel.text = item.title
        self.bodyLabel.text = item.body
        self.viewGemsButton.setTitle(item.buttonTitle, for: .normal)
    }
    
    override func prepareForReuse() {
        self.radarImageView?.image = nil
    }
}
