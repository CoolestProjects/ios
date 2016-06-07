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
    
    var mapModel = MapsModel(data: [("Car Park", "https://pbs.twimg.com/media/CkSWu6RWgAAwcoY.jpg:large"), ("Other Place", "https://pbs.twimg.com/media/CkSWu6RWgAAwcoY.jpg:large")])
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
        cell.displayModel(item)
        
        return cell
    }
}

extension MapsViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        
    }
}
