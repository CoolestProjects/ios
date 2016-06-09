//
//  SponsorTableViewCell.swift
//  CoolestProjects
//
//  Created by BooRanger on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorTableViewCell: UITableViewCell {

    @IBOutlet weak var sponsorImageView: UIImageView!
    
    func displayViewModel(sponsorViewModel : SponsorViewModel) {
        
          sponsorImageView.sd_setImageWithURL(NSURL(string: sponsorViewModel.logoUrl))
    }
}
