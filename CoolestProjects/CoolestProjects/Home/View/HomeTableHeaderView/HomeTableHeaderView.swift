//
//  HomeTableHeaderView.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 04/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class HomeTableHeaderView : UIView, Configurable {
    typealias ItemType = (String, String)
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    class func headerView() -> HomeTableHeaderView? {
        return Bundle.main.loadNibNamed("HomeTableHeaderView", owner: nil, options: nil)?.first as? HomeTableHeaderView
    }
    
    func configure(with item: ItemType) {
        // TODO: struct or tuple with names???
        title.text = item.0
        body.text = item.1
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        title.preferredMaxLayoutWidth = title.bounds.width
        body.preferredMaxLayoutWidth = body.bounds.width
    }
}
