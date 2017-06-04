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
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    weak var tableView: UITableView!

    func configure(with item: AboutModel) {
      //TO DO: create a return block
      self.activityIndicatorView.startAnimating()
      let request = URLRequest(url: item.aboutContentURL)
      webView.loadRequest(request)
        
      self.activityIndicatorView.stopAnimating()
      self.titleLabel?.text = item.title
    }
    
}

extension AboutViewTableViewCell : UIWebViewDelegate  {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
 
        
        let height = webView.scrollView.contentSize.height;
        
        if height != self.webViewHeight.constant && height > 40{
            self.webViewHeight.constant = height;
        
            webView.scrollView.isScrollEnabled = false
            tableView.reloadData()

        }
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
            return false
        }
        return true
    }
}
