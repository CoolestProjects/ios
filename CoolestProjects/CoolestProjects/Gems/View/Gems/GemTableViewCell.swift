//
//  GemTableViewCell.swift
//  CoolestProjects
//
//  Created by Rich on 30/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class GemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var messageLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeToFit()
        layoutIfNeeded()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelTextColor(_ color: UIColor) {
        self.titleLabel?.textColor = color
        self.messageLabel?.textColor = color
    }
    
}
