//
//  ProjectTableViewCell.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 08/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class ProjectTableViewCell : UITableViewCell, Configurable {
    typealias ItemType = Project
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var coderdojo: UILabel!
    @IBOutlet weak var desk: UILabel!
    
    func configure(withItem item: ItemType) {
        name.text = item.name.uppercased()
        projectDescription.text = item.projectDescription
        category.text = sanitizeCategory(item.category)
        coderdojo.text = item.coderdojo
        desk.text = formattedDeskText(item.deskNumber ?? "")
    }
    
    func sanitizeCategory(_ category: String) -> String {
        if category == "null" {
            return "--"
        }
        
        return category
    }
    
    func formattedDeskText(_ deskNumber: String) -> String {
        let desk = deskNumber.isEmpty ? "-" : deskNumber
        return "Desk: \(desk)"
    }
    
}
