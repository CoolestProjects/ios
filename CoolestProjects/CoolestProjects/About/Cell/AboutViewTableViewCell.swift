//
//  AboutViewTableViewCell.swift
//  CoolestProjects
//
//  Created by Natasha Cole on 25/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit
import SDWebImage

class AboutViewTableViewCell: UITableViewCell, Configurable {
    typealias ItemType = AboutModel

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func configure(with item: AboutModel) {
        
        self.activityIndicatorView.startAnimating()
        
//        self.mapImageView.sd_setImage(with: URL(string: item.mapUrl)) { [weak self] (image, error, cache, url) in
//            self?.activityIndicatorView.stopAnimating()
//            self?.setNeedsLayout()
//            self?.layoutIfNeeded()
//        }
      
        self.titleLabel?.text = item.title
        
    }
    
}
