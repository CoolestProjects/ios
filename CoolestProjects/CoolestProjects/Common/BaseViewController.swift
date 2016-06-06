//
//  BaseViewController.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit
import SWRevealViewController

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftButtonItem()
        addGestureRecognizers()
        setupNavigationBar()
    }
    
    func addLeftButtonItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target:self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    
    func addGestureRecognizers() {
        self.revealViewController().panGestureRecognizer()
        self.revealViewController().tapGestureRecognizer()
    }
    
    func setupNavigationBar() {
        //TODO: Viewmodel
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationItem.title = NSLocalizedString("navbar.title",tableName: "Speakers", comment: "")
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: AppColors.yellowColor
        ]
        
        
    }
}
