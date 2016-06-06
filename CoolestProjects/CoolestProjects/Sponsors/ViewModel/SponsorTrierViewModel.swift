//
//  SponsorTrierViewModel.swift
//  CoolestProjects
//
//  Created by BooRanger on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorTrierViewModel {

    var tableViewData : [SponsorViewModel]?

    static func buildSponsorTierViewModels(sponsorTier: NSArray ) {
        
    }
    
    var tierName : String?
    var sponsors : Array<SponsorViewModel>?

    init(sponsorTier: CPASponsorTier) {
        
        tierName = sponsorTier.tier
        sponsors = SponsorViewModel.buildSponsorViewModels(sponsorTier.sponsors)
    }
    
}


class SponsorViewModel {
    
    static func buildSponsorViewModels(sponsors: NSArray ) -> [SponsorViewModel] {
        var sponsorViewModels : [SponsorViewModel] = []
        
        for sponsor in sponsors {
            let sponsorViewmodel = SponsorViewModel(sponsor: sponsor as! CPASponsor)
            sponsorViewModels.append(sponsorViewmodel)
        }
        
        return sponsorViewModels
    }
    
    var nameText : String
    var logoUrl : String
    var descriptionText : String
    
    init(sponsor: CPASponsor) {
        nameText = sponsor.name
        logoUrl = sponsor.logoUrl
        descriptionText = sponsor.sponsorDescription
    }
}