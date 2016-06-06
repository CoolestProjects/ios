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

    
    func buildSpeakerViewModels(speakers  : NSArray) -> [SpeakerViewModel] {
        
        
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
    var componentIdentifier: String
    
    var dividerColor : UIColor = UIColor.init(colorLiteralRed: 200, green: 200, blue: 200, alpha: 1.0)

    init(speaker : CPASpeaker) {
       componentIdentifier = "speakerCell"

        name = speaker.name
        speakerDescription = speaker.speakerDescription
        imageUrl = speaker.photoUrl
        
    }
    
}