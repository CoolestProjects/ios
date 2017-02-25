//
//  MapViewCollectionViewCell.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit
import SDWebImage

class MapViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func displayModel(_ model : (title: String, mapUrl: String), collectionView: UICollectionView) {
        self.activityIndicatorView.startAnimating()

        self.mapImageView.sd_setImage(with: URL(string: model.mapUrl)) { [weak self] (image, error, cache, url) in
            collectionView.collectionViewLayout.invalidateLayout()
            self?.activityIndicatorView.stopAnimating()
        }

        self.titleLabel?.text = model.0
    }
}
