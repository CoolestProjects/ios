//
//  ContentTableViewCell.swift
//  CoolestProjects
//
//  Created by Colin Pierse on 21/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell, Configurable {
    typealias ItemType = ContentViewModel

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var view: UIView!
    
    func configure(with item: ContentViewModel) {
        self.iconImage.image = item.icon
        self.title.text = item.title

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.4

        let attrString = NSMutableAttributedString(string: item.body)
        attrString.addAttributes(
            [NSParagraphStyleAttributeName: paragraphStyle,
             NSForegroundColorAttributeName: UIColor.contentItemTitle],
            range: NSMakeRange(0, attrString.length))

        self.body.attributedText = attrString
    }
    
    override func prepareForReuse() {
        iconImage.image = nil
    }
    
}
