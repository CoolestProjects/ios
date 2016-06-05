//
//  NibLoadable.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 04/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable {
    // TODO: try to extract the nib loading logic in a protocol/extension
    static func loadFromNib() -> Self?
}

//extension NibLoadable {
//    
//    static func loadFromNib() -> Self? {
//        let nibName = String(self.dynamicType)
//        return NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil).first as? Self
//    }
//    
//}