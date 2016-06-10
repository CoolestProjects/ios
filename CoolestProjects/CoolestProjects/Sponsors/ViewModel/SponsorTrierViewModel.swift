//
//  SponsorTrierViewModel.swift
//  CoolestProjects
//
//  Created by BooRanger on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorsViewModel {
    
}

class SponsorTrierViewModel {

    static func buildSponsorTierViewModels(sponsorTiers: NSArray ) -> [SponsorTrierViewModel] {
        var sponsorTierViewModels : [SponsorTrierViewModel] = []
        
        for sponsorTier in sponsorTiers {
            let sponsorViewmodel = SponsorTrierViewModel(sponsorTier: sponsorTier as! CPASponsorTier)
            sponsorTierViewModels.append(sponsorViewmodel)
        }
        
        return sponsorTierViewModels
    }
    
    var tierName : String?
    var sponsors : Array<SponsorViewModel>?
    let tierColor = AppColors.lightGreyColor
    
    init(sponsorTier: CPASponsorTier) {
        
        tierName = sponsorTier.tier
        sponsors = SponsorViewModel.buildSponsorViewModels(sponsorTier.sponsors)
    }
    
}


class SponsorViewModel: Component {
    
    static func buildSponsorViewModels(sponsors: NSArray ) -> [SponsorViewModel] {
        var sponsorViewModels : [SponsorViewModel] = []
        
        for sponsor in sponsors {
            let sponsorViewmodel = SponsorViewModel(sponsor: sponsor as! CPASponsor)
            sponsorViewModels.append(sponsorViewmodel)
        }
        
        return sponsorViewModels
    }
    
    var logoUrl : String
    var componentIdentifier: String = "sponsorCell"

    init(sponsor: CPASponsor) {
        logoUrl = sponsor.logoUrl
    }
}