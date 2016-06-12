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
    var selectImage : UIImage?
    var mapModel = MapsModel(data: [(title: NSLocalizedString("map.rds", tableName: "Maps", comment: ""), mapUrl: "https://firebasestorage.googleapis.com/v0/b/coolestprojectsapp.appspot.com/o/Maps%2Fcoolestprojectsmap.png?alt=media&token=cf6515dd-9947-4595-a203-422c6427a2ca")])
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("title", tableName: "Maps", comment: "")
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
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MapViewCollectionViewCell
        self.selectImage = cell.mapImageView.image
        
        
        let viewController = MapZoomViewController()
        viewController.image = self.selectImage
        viewController.navigationTitle = self.mapModel.data[indexPath.row].title
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.presentViewController(navigationController, animated: true, completion: nil)
        
    }
}

extension MapsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let collectionView = self.collectionView {
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? MapViewCollectionViewCell {

                if let cellImage = cell.mapImageView?.image {
                    let widthRatio = collectionView.frame.size.width / cellImage.size.width
                    return CGSizeMake((collectionView.frame.size.width), 38 + cellImage.size.height * widthRatio)
                }
            }
            return CGSizeMake(collectionView.frame.size.width, 150)
        }
        
        return CGSizeZero 
    }
    
}