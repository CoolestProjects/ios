//
//  HomeTableFooterView.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 04/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class HomeTableFooterView : UIView {
    
    class func footerView() -> HomeTableFooterView? {
        return NSBundle.mainBundle().loadNibNamed("HomeTableFooterView", owner: nil, options: nil).first as? HomeTableFooterView
    }

}