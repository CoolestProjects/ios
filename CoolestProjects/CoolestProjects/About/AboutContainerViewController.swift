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
        
        aboutSectionsSegmentedControl.setTitle(NSLocalizedString("section.about", tableName: "About", comment: ""), forSegmentAtIndex: aboutIndex)
        aboutSectionsSegmentedControl.setTitle(NSLocalizedString("section.disclaimer", tableName: "About", comment: ""), forSegmentAtIndex: disclaimerIndex)
        
        let normalStateAttributes = [
            NSFontAttributeName: AppFonts.tabBarFontSelected,
            NSForegroundColorAttributeName: AppColors.darkTextColor
        ]
        
        let selectedStateAttributes = [
            NSFontAttributeName: AppFonts.tabBarFontSelected,
            NSForegroundColorAttributeName: AppColors.blueColor
        ]
                            
        aboutSectionsSegmentedControl.setTitleTextAttributes(normalStateAttributes, forState: .Normal)
        aboutSectionsSegmentedControl.setTitleTextAttributes(selectedStateAttributes, forState: .Selected)
        
        aboutSectionsSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
        aboutSectionsSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .Selected, rightSegmentState: .Normal, barMetrics: .Default)
        aboutSectionsSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .Normal, rightSegmentState: .Selected, barMetrics: .Default)
        
        aboutSectionsSegmentedControl.setBackgroundImage(UIImage(), forState: .Normal, barMetrics: .Default)
        aboutSectionsSegmentedControl.setBackgroundImage(UIImage(), forState: .Selected, barMetrics: .Default)                        
    }
    
    @IBAction func changeAboutSection(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == aboutIndex {
            showAboutContainer()
        } else {
            showDisclaimerContainer()
        }
    }
    
    func showAboutContainer() {
        UIView.animateWithDuration(showContainerAnimationDuration, animations: {
            self.aboutContainerView.alpha = 1
            self.disclaimerContainerView.alpha = 0
        })
    }
    
    func showDisclaimerContainer() {
        UIView.animateWithDuration(showContainerAnimationDuration, animations: {
            self.aboutContainerView.alpha = 0
            self.disclaimerContainerView.alpha = 1
        })
    }
    
}

