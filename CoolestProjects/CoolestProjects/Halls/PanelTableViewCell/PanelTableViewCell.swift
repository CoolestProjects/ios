//
//  PanelTableViewCell.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 27/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class PanelTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var speakersStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = UIColor.battleshipGrey
        timeLabel.textColor = UIColor.battleshipGrey
        descriptionLabel.textColor = UIColor.battleshipGrey
    }

    override func prepareForReuse() {
        speakersStackView.arrangedSubviews.forEach { (view) in
            speakersStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}

extension PanelTableViewCell: Configurable {
    typealias ItemType = Panel

    func configure(with item: ItemType) {
        titleLabel.text = item.name.uppercased()
        timeLabel.text = "\(item.startTime) - \(item.endTime)"
        descriptionLabel.text = item.description

        item.speakers.forEach { (speaker) in
            let speakerView = PanelSpeakerView(frame: CGRect.zero)
            speakerView.configure(with: speaker)
            speakersStackView.addArrangedSubview(speakerView)
        }
    }
}
