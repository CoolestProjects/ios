//
//  GemsViewModel.swift
//  CoolestProjects
//
//  Created by Rich on 29/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class GemsViewModel {
    
    var items:[GemItem] = [GemItem]()
    
    init(beaconItems : [RegionMessageInteraction]) {
        
        items = createGemItems(beaconItems: beaconItems)
    }
    
    func createGemItems(beaconItems :[RegionMessageInteraction]) -> [GemItem] {
        var gemItems = [GemItem]()
        
        for beaconItem in beaconItems {
            let gemItem = GemItem(title: beaconItem.title, message: beaconItem.message)
            
            gemItems.append(gemItem)
        }
        
        return gemItems
    }
    
    func shouldShowEmptyState() -> Bool{
        
        return items.count == 0
    }
}

class GemItem {
    
    let title: String
    let message: String
    
    init(title :String, message: String) {
        
        self.title = title
        self.message = message
    }
}
