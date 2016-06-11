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
    
    func setupNavigationBar() {
        title = NSLocalizedString("title", tableName: "About", comment: "")
        
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: AppFonts.navigationBarTitle,
            NSForegroundColorAttributeName: AppColors.yellowColor
        ]        
    }
    
}

