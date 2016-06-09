//
//  SponsorTableViewHeader.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 09/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorTableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    func displayViewModel(viewModel: SponsorTrierViewModel) {
        self.titleLabel.text = viewModel.tierName
    }

}
