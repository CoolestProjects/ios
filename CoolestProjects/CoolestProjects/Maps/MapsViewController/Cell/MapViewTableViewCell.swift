//
//  MapViewTableViewCell.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 25/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit
import SDWebImage

class MapViewTableViewCell: UITableViewCell, Configurable {
    typealias ItemType = MapsModel
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func configure(with item: MapsModel) {
        
        self.activityIndicatorView.startAnimating()
        
        self.mapImageView.sd_setImage(with: URL(string: item.mapUrl)) { [weak self] (image, error, cache, url) in
            self?.activityIndicatorView.stopAnimating()
            self?.layoutIfNeeded()
        }
        
        self.titleLabel?.text = item.title
        
    }
    
}
