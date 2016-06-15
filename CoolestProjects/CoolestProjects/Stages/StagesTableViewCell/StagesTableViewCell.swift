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
        
        photo = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        textView.addSubview(photo)
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsetsZero
    }
    
    func configure(withItem item: ItemType) {
        // TODO: better layout logic and remove these magic numbers
        photo.frame = CGRectMake(0, 0, 100, 100)
        let exclusionPath = UIBezierPath(rect: CGRectMake(0, 0, 110, 110))
        textView.textContainer.exclusionPaths = [exclusionPath]
        
        textView.attributedText = buildAttributedString(withSpeaker: item)
        photo.sd_setImageWithURL(NSURL(string: item.photoUrl), placeholderImage: UIImage(named: "null-avatar"))
    }
    
    override func prepareForReuse() {
        photo?.image = UIImage(named: "null-avatar")
    }
    
    func buildAttributedString(withSpeaker speaker:CPASpeaker) -> NSAttributedString {
        let finalString = NSMutableAttributedString(attributedString: speakerName(speaker))
        finalString.appendAttributedString(NSAttributedString(string: "\n"))
        finalString.appendAttributedString(talkTitle(speaker))
        finalString.appendAttributedString(NSAttributedString(string: "\n"))
        finalString.appendAttributedString(talkTime(speaker))
        finalString.appendAttributedString(NSAttributedString(string: "\n"))
        finalString.appendAttributedString(speakerDescription(speaker))
        
        return finalString
    }
    
    func speakerName(speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.name, font:AppFonts.speakerTextFont, color: AppColors.darkTextColor)
    }
    
    func speakerDescription(speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.speakerDescription, font:AppFonts.speakerDescriptionFont, color: AppColors.lightGreyTextColor)
    }
    
    func talkTitle(speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.talkTitle, font:AppFonts.speakerDescriptionFont, color: AppColors.darkTextColor)
    }
    
    func talkTime(speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.summitTimesAsString, font:AppFonts.speakerDescriptionFont, color: AppColors.redColor)
    }
    
    func attributedText(text: String, font: UIFont, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: [NSFontAttributeName:font, NSForegroundColorAttributeName: color])
    }
}
