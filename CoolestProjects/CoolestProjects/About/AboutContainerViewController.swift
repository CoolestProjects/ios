//
//  AboutContainerViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 11/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class AboutContainerViewController : BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func setupNavigationBar() {
        title = NSLocalizedString("title", tableName: "About", comment: "")
        
        super.setupNavigationBar()
    }
    
}

