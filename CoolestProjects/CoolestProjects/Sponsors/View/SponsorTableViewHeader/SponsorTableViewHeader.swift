//
//  SponsorTableViewHeader.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 09/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorTableViewHeader: UITableViewHeaderFooterView {

    var titleLabel: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupTitleLabel() {
        
        let label = UILabel()
        label.font = AppFonts.tableHeaderTitle
        label.textAlignment = .Center
        self.contentView.addSubview(label);
        
        self.titleLabel = label
    
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor).active = true
        label.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor).active = true
        label.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor).active = true
        label.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor).active = true
    }
    
    func displayViewModel(viewModel: SponsorTrierViewModel) {
        self.titleLabel.text = viewModel.tierName
        self.contentView.backgroundColor = viewModel.tierColor
    }

}
