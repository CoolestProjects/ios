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
        label.textAlignment = .center
        self.contentView.addSubview(label);
        
        self.titleLabel = label
    
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func displayViewModel(_ viewModel: SponsorTrierViewModel) {
        self.titleLabel.text = viewModel.tierName
        self.contentView.backgroundColor = viewModel.tierColor
    }

}
