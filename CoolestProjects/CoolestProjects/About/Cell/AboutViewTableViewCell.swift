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
      //TO DO: create a return block
      self.activityIndicatorView.startAnimating()
      let request = URLRequest(url: item.aboutContentURL)
      webView.loadRequest(request)
      self.activityIndicatorView.stopAnimating()
      self.titleLabel?.text = item.title
    }
  
}
