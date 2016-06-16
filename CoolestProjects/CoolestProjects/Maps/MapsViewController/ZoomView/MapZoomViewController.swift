//
//  MapZoomViewController.swift
//  CoolestProjects
//
//  Created by Richard Toolan on 11/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class MapZoomViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    var navigationTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: AppColors.yellowColor,
            NSFontAttributeName : AppFonts.navbarTitleFont
        ]
        


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = self.image
        self.title = self.navigationTitle
        
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(MapZoomViewController.donePressed)), animated: false)
        
        let buttonAttributes = [
            NSFontAttributeName: AppFonts.navigationBarButton,
            NSForegroundColorAttributeName: AppColors.yellowColor
        ]
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(buttonAttributes, forState: .Normal)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView;
    }
    
    func donePressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
