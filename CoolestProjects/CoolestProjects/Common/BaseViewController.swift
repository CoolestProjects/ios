//
//  BaseViewController.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    let deepLinkDataIdentifier = "identifier"
    
    var deeplinkData: [String: String] = ["":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationBar()
    }

    func setupNavigationBar() {
//        //TODO: Viewmodel
//        navigationController?.navigationBar.barTintColor = UIColor.black
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.titleTextAttributes = [
//            NSForegroundColorAttributeName: AppColors.darkTextColor,
//            NSFontAttributeName : AppFonts.navbarTitleFont
//        ]
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
