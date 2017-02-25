//
//  StagesTableViewCell.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class StagesTableViewCell : UITableViewCell, Configurable {
    typealias ItemType = CPASpeaker
    
    @IBOutlet weak var textView: UITextView!
    var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photo = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textView.addSubview(photo)
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets.zero
    }
    
    func configure(withItem item: ItemType) {
        // TODO: better layout logic and remove these magic numbers
        photo.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let exclusionPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 110, height: 110))
        textView.textContainer.exclusionPaths = [exclusionPath]
        
        textView.attributedText = buildAttributedString(withSpeaker: item)
        photo.sd_setImage(with: URL(string: item.photoUrl), placeholderImage: UIImage(named: "null-avatar"))
    }
    
    override func prepareForReuse() {
        photo?.image = UIImage(named: "null-avatar")
    }
    
    func buildAttributedString(withSpeaker speaker:CPASpeaker) -> NSAttributedString {
        let finalString = NSMutableAttributedString(attributedString: speakerName(speaker))
        
        if (!speaker.name.isEmpty) {
            finalString.append(NSAttributedString(string: "\n"))
        }
        
        finalString.append(talkTitle(speaker))
        
        if (!speaker.talkTitle.isEmpty) {
            finalString.append(NSAttributedString(string: "\n"))
        }
        
        finalString.append(talkTime(speaker))
        
        if (!speaker.summitTimesAsString.isEmpty) {
            finalString.append(NSAttributedString(string: "\n"))
        }
        
        finalString.append(speakerDescription(speaker))
        
        return finalString
    }
    
    func speakerName(_ speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.name, font:AppFonts.speakerTextFont, color: AppColors.darkTextColor)
    }
    
    func speakerDescription(_ speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.speakerDescription, font:AppFonts.speakerDescriptionFont, color: AppColors.lightGreyTextColor)
    }
    
    func talkTitle(_ speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.talkTitle, font:AppFonts.speakerDescriptionFont, color: AppColors.darkTextColor)
    }
    
    func talkTime(_ speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.summitTimesAsString, font:AppFonts.speakerDescriptionFont, color: AppColors.redColor)
    }
    
    func attributedText(_ text: String, font: UIFont, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: [NSFontAttributeName:font, NSForegroundColorAttributeName: color])
    }
}
