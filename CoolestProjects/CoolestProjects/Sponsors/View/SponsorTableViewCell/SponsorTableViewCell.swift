//
//  SponsorTableViewCell.swift
//  CoolestProjects
//
//  Created by BooRanger on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorTableViewCell: SponsorBoxTableViewCell {
    
    @IBOutlet weak var educationTitle: UILabel!
    @IBOutlet weak var educationStackView: UIStackView!
    
    @IBOutlet weak var silverTitle: UILabel!
    @IBOutlet weak var silverStackView: UIStackView!
    
    @IBOutlet weak var bronzeTitle: UILabel!
    @IBOutlet weak var bronzeStackView: UIStackView!
 
    override func configure(with item: SponsorBox) {
        super.configure(with: item)
        
        silverTitle.text = item.silverTitle
        bronzeTitle.text = item.bronzeTitle
        educationTitle.text = item.educationTitle

        
        for image in item.silverImages! {
            silverStackView.addArrangedSubview(UIImageView(image: image))
        }
        for image in item.bronzeImages! {
            bronzeStackView.addArrangedSubview(UIImageView(image: image))
        }
        for image in item.educationImages! {
            educationStackView.addArrangedSubview(UIImageView(image: image))
        }
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.removeViewsFrom(stackView: silverStackView)
        self.removeViewsFrom(stackView: bronzeStackView)
        self.removeViewsFrom(stackView: educationStackView)
    }
    
}

    
