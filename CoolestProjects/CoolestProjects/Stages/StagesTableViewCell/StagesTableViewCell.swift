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
        
        photo = UIImageView(frame: CGRectMake(0, 0, 130, 130))
        textView.addSubview(photo)
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsetsZero
    }
    
    func configure(withItem item: ItemType) {
        // TODO: better layout logic and remove these magic numbers
        photo.frame = CGRectMake(CGRectGetWidth(self.frame) - 170, 0, 130, 130)
        let exclusionPath = UIBezierPath(rect: CGRectMake(CGRectGetWidth(self.frame) - 180, 0, 140, 140))
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
        finalString.appendAttributedString(speakerDescription(speaker))
        finalString.appendAttributedString(NSAttributedString(string: "\n"))
        finalString.appendAttributedString(talkTitle(speaker))
        finalString.appendAttributedString(NSAttributedString(string: "\n"))
        finalString.appendAttributedString(talkTime(speaker))
        
        return finalString
    }
    
    func speakerName(speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.name, color: AppColors.darkTextColor)
    }
    
    func speakerDescription(speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.speakerDescription, color: AppColors.lightGreyTextColor)
    }
    
    func talkTitle(speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.talkTitle, color: AppColors.darkTextColor)
    }
    
    func talkTime(speaker: CPASpeaker) -> NSAttributedString {
        return attributedText(speaker.summitTimesAsString, color: AppColors.redColor)
    }
    
    func attributedText(text: String, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: [NSFontAttributeName:AppFonts.speakerTextFont, NSForegroundColorAttributeName: color])
    }
}
