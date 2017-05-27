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
    
    typealias ItemType = BluetoothBox
    
    func configure(with item: ItemType) {
        self.radarImageView?.image = UIImage.animatedImageNamed("radar-", duration: 0.9)
    }
}
