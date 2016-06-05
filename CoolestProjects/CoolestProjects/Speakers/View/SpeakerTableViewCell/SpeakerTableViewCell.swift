//
//  SpeakerTableViewCell.swift
//  CoolestProjects
//
//  Created by BooRanger on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit
import SDWebImage

class SpeakerTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speakerDescriptionLabel: UILabel!
    
    @IBOutlet weak var divider: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    
    func displayViewModel(speakerViewModel : SpeakerViewModel) {
        
        nameLabel.text = speakerViewModel.name
        speakerDescriptionLabel.text = speakerViewModel.speakerDescription
        divider.backgroundColor = speakerViewModel.dividerColor
        
        speakerImageView?.sd_setImageWithURL(NSURL(string: speakerViewModel.imageUrl!))
        
    }
}
