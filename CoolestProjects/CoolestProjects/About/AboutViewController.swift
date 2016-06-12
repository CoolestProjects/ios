//
//  AboutViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 11/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController : UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAboutContent()
    }
    
    func loadAboutContent() {
        if let aboutURL = NSBundle.mainBundle().URLForResource("about", withExtension: "html") {
            let request = NSURLRequest(URL: aboutURL)
            webView.loadRequest(request)
        }
    }
    
}
