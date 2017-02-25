 //
//  SpeakersViewModel.swift
//  CoolestProjects
//
//  Created by BooRanger on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SpeakersViewModel {
    
    var tableViewData : [SpeakerViewModel]?
    
    
    init (speakers : NSArray ) {
        tableViewData = buildSpeakerViewModels(speakers)
        
    }

    
    func buildSpeakerViewModels(_ speakers  : NSArray) -> [SpeakerViewModel] {
        
        
        var speakerViewModels : [SpeakerViewModel] = []
        for speaker in speakers {
            let speakerViewModel = SpeakerViewModel(speaker: speaker as! CPASpeaker)
            speakerViewModels.append(speakerViewModel)
        }
        
        
        return speakerViewModels
    }

}


class SpeakerViewModel : Component  {
    
    var name : String?
    var speakerDescription: String?
    var imageUrl :String?
    var componentIdentifier: String = "speakerCell"
    
    var placeholderImage: UIImage = UIImage(named: "null-avatar")!
    var dividerColor : UIColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    var nameTextColor : UIColor = UIColor(red:0.20, green:0.21, blue:0.20, alpha:1.00)
    var speakerDescriptionTextColor : UIColor = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.00)
    
    
    init(speaker : CPASpeaker) {
        name = speaker.name.uppercased()
        speakerDescription = speaker.speakerDescription
        imageUrl = speaker.photoUrl
        
    }
    
 }
 
