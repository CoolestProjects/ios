//
//  PanelSpeakerView.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 27/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import UIKit

final class PanelSpeakerView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("PanelSpeakerView", owner: self, options: [:])
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        nameLabel.textColor = UIColor.battleshipGrey
        titleLabel.textColor = UIColor.battleshipGrey

        photoImageView.layer.cornerRadius = 40
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.borderWidth = 0
    }

}

extension PanelSpeakerView: Configurable {
    typealias ItemType = Speaker

    func configure(with item: ItemType) {
        photoImageView.image = UIImage(named: "null-avatar")
        if let photoUrl = item.photoUrl, let url = URL(string: photoUrl) {
            photoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "null-avatar"))
        }

        nameLabel.text = item.name
        titleLabel.text = item.title
    }
    
}
