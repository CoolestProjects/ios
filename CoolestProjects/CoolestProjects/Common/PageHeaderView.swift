//
//  PageHeaderView.swift
//  CoolestProjects
//
//  Created by Natasha Cole on 20/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class PageHeaderView: UIView {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    class func pageHeaderView() -> PageHeaderView? {
        return Bundle.main.loadNibNamed("PageHeaderView", owner: nil, options: nil)?.first as? PageHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoLabel.text = NSLocalizedString("pageheader.info", tableName: "Common", comment: "showcase blurb")
    }
    
}
