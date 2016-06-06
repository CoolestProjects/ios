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
        self.addLeftButtonItem();
        super.viewDidLoad()
    }
    
    func addLeftButtonItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target:self, action: #selector(BaseViewController.reveal))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    
    func reveal() {
        self.revealViewController().revealToggle(nil)
    }
    
    
}
