//
//  PageHeaderTableViewCell.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 21/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class PageHeaderTableViewCell: UITableViewCell {

    var pageHeaderView : PageHeaderView = PageHeaderView.pageHeaderView()!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(pageHeaderView)
        pageHeaderView.translatesAutoresizingMaskIntoConstraints = false
        pageHeaderView.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        pageHeaderView.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        pageHeaderView.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        pageHeaderView.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
