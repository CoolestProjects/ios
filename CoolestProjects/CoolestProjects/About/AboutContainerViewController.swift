//
//  AboutContainerViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 11/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

let showContainerAnimationDuration = 0.0
let aboutIndex = 0
let disclaimerIndex = 1

class AboutContainerViewController : BaseViewController {
  
    @IBOutlet weak var aboutContainerView: UIView!
    @IBOutlet weak var disclaimerContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupNavigationBar()
    }
    
    override func setupNavigationBar() {
        title = NSLocalizedString("title", tableName: "About", comment: "")
        super.setupNavigationBar()
    }
  
    @IBAction func changeAboutSection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == aboutIndex {
            showAboutContainer()
        } else {
            showDisclaimerContainer()
        }
    }
    
    func showAboutContainer() {
        UIView.animate(withDuration: showContainerAnimationDuration, animations: {
            self.aboutContainerView.alpha = 1
            self.disclaimerContainerView.alpha = 0
        })
    }
    
    func showDisclaimerContainer() {
        UIView.animate(withDuration: showContainerAnimationDuration, animations: {
            self.aboutContainerView.alpha = 0
            self.disclaimerContainerView.alpha = 1
        })
    }
    
}

