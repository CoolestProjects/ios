//
//  SponsorTableViewCell.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 04/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class SponsorBoxTableViewCell : UITableViewCell, Configurable {
    typealias ItemType = SponsorBox
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var diamondStackView: UIStackView!
    @IBOutlet weak var platinumStackView: UIStackView!
    @IBOutlet weak var platinumLowerStackView: UIStackView!
    @IBOutlet weak var goldStackView: UIStackView!

    func configure(with item: ItemType) {
        title.text = item.title
        
        for image in item.diamondImages {
            diamondStackView.addArrangedSubview(UIImageView(image: image))
        }
        for image in item.platinumHigherImages {
            platinumStackView.addArrangedSubview(UIImageView(image: image))
        }
        for image in item.platinumLowerImages {
            platinumLowerStackView.addArrangedSubview(UIImageView(image: image))
        }
        for image in item.goldImages {
            goldStackView.addArrangedSubview(UIImageView(image: image))
        }
    }
    
    override func prepareForReuse() {
        // TODO: check the performace of this. Seems very wasteful. 
        self.removeViewsFrom(stackView: diamondStackView)
        self.removeViewsFrom(stackView: platinumStackView)
        self.removeViewsFrom(stackView: platinumLowerStackView)
        self.removeViewsFrom(stackView: goldStackView)

    }
    
    func removeViewsFrom( stackView: UIStackView) {
        for view in stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    
}
