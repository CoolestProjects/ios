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
    
    @IBOutlet weak var aboutSectionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var aboutContainerView: UIView!
    @IBOutlet weak var disclaimerContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupNavigationBar()
        setupAboutSectionsSegmentedControl()
    }
    
    override func setupNavigationBar() {
        title = NSLocalizedString("title", tableName: "About", comment: "")
        super.setupNavigationBar()
    }
    
    func setupAboutSectionsSegmentedControl() {
        
        aboutSectionsSegmentedControl.setTitle(NSLocalizedString("section.about", tableName: "About", comment: ""), forSegmentAt: aboutIndex)
        aboutSectionsSegmentedControl.setTitle(NSLocalizedString("section.disclaimer", tableName: "About", comment: ""), forSegmentAt: disclaimerIndex)
        
        let normalStateAttributes = [
            NSFontAttributeName: AppFonts.tabBarFontSelected,
            NSForegroundColorAttributeName: AppColors.darkTextColor
        ]
        
        let selectedStateAttributes = [
            NSFontAttributeName: AppFonts.tabBarFontSelected,
            NSForegroundColorAttributeName: AppColors.darkTextColor
        ]
                            
        aboutSectionsSegmentedControl.setTitleTextAttributes(normalStateAttributes, for: .normal)
        aboutSectionsSegmentedControl.setTitleTextAttributes(selectedStateAttributes, for: .selected)
        
        aboutSectionsSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        aboutSectionsSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        aboutSectionsSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
        
        aboutSectionsSegmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        aboutSectionsSegmentedControl.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)                        
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

