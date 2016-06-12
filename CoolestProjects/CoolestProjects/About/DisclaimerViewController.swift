//
//  DisclaimerViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 12/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class DisclaimerViewController : UIViewController {
    
    @IBOutlet weak var disclaimerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDisclaimerContent()
    }
    
    func loadDisclaimerContent() {
        let firebaseService = CPAFirebaseDefaultService()
        firebaseService.getAboutInfoWithCompletionBlock { [weak self] (about, error) in
            if let about = about {
                self?.disclaimerLabel.text = about.disclaimerText
            } else {
                self?.disclaimerLabel.text = ""
            }
        }
    }
    
}
