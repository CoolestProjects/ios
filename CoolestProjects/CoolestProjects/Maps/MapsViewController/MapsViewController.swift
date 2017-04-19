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
        
        self.collectionView?.register(nibName, forCellWithReuseIdentifier: "cell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BeaconNotificationsManager.sharedInstance.requestAuthorization()
    }
}

extension MapsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapModel.numberOfItems;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = mapModel.item(atIndex: indexPath.row)! as (String, String)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MapViewCollectionViewCell
        cell.displayModel(item, collectionView: self.collectionView!)
        
        return cell
    }
}

extension MapsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MapViewCollectionViewCell
        self.selectImage = cell.mapImageView.image
        
        
        let viewController = MapZoomViewController()
        viewController.image = self.selectImage
        viewController.navigationTitle = self.mapModel.data[indexPath.row].title
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.present(navigationController, animated: true, completion: nil)
        
    }
}

extension MapsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let collectionView = self.collectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? MapViewCollectionViewCell {

                if let cellImage = cell.mapImageView?.image {
                    let widthRatio = collectionView.frame.size.width / cellImage.size.width
                    return CGSize(width: (collectionView.frame.size.width), height: 38 + cellImage.size.height * widthRatio)
                }
            }
            return CGSize(width: collectionView.frame.size.width, height: 150)
        }
        
        return CGSize.zero 
    }
    
}
