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
    
    func displayModel(model : (String, String), collectionView: UICollectionView) {
        self.activityIndicatorView.startAnimating()
        self.mapImageView.sd_setImageWithURL(NSURL(string: model.1), completed: { [unowned self] (image : UIImage!, error : NSError!, cache: SDImageCacheType, url: NSURL!) in
            collectionView.collectionViewLayout.invalidateLayout()
            self.activityIndicatorView.stopAnimating()
        });
        self.titleLabel?.text = model.0
    }
}
