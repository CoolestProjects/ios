//
//  MapsViewController.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class MapsViewController: BaseViewController {
    @IBOutlet weak var collectionView : UICollectionView?
    
    var mapModel = MapsModel(data: [("Car Park", "https://www.ucd.ie/students/assessment/images/Simmoncourt-venue-map.gif"), ("Other Place", "https://www.rds.ie/images/venue_map_2015.gif")])
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Maps", comment: "Maps")
        let nibName = UINib(nibName: "MapViewCollectionViewCell", bundle:nil)
        
        self.collectionView?.registerNib(nibName, forCellWithReuseIdentifier: "cell")
    }
}

extension MapsViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapModel.numberOfItems;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = mapModel.item(atIndex: indexPath.row)! as (String, String)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MapViewCollectionViewCell
        cell.displayModel(item, collectionView: self.collectionView!)
        
        return cell
    }
}

extension MapsViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        
    }
}

extension MapsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let collectionView = self.collectionView {
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? MapViewCollectionViewCell {
//                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MapViewCollectionViewCell
                if let cellImage = cell.mapImageView?.image {
                    let widthRatio = collectionView.frame.size.width / cellImage.size.width
                    return CGSizeMake((collectionView.frame.size.width), 38 + cellImage.size.height * widthRatio)
                }
            }
            return CGSizeMake(collectionView.frame.size.width, 100)
        }
        
        return CGSizeZero
    }
    
}