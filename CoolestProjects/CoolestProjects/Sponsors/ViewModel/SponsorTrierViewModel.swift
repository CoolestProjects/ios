//
//  SponsorTrierViewModel.swift
//  CoolestProjects
//
//  Created by BooRanger on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorViewModel {
    
    var tableViewData = [Component]()
    init() {
        createTableViewData()
    }
    
    private func createTableViewData() {

        let image = UIImage(color: UIColor.clear, size:  UIImage(named: "sponsor_silver_twitter")!.size)!

        tableViewData = [
            SponsorBox(title: NSLocalizedString("sponsor.title", tableName: "Home", comment: ""),
                       diamondTitle:NSLocalizedString("sponsor.diamond.title", tableName: "Home", comment: "") ,
                       platinumTitle:NSLocalizedString("sponsor.platinum.title", tableName: "Home", comment: "") ,
                       goldTitle:NSLocalizedString("sponsor.gold.title", tableName: "Home", comment: "") ,
                       supporterTitle:NSLocalizedString("sponsor.supporter.title", tableName: "Sponsors", comment: ""),
                       diamondImages: [
                        image,
                        UIImage(named: "sponsor_diamond_intel")!,
                        UIImage(named: "sponsor_diamond_microsoft")!,
                        image
                       ],
                       platinumHigherImages: [
                        UIImage(named: "sponsor_platinum_openet")!,
                        UIImage(named: "sponsor_platinum_rte")!,
                        UIImage(named: "sponsor_platinum_mastercard")!,
                        UIImage(named: "sponsor_platinum_boi")!],
                       platinumLowerImages: [
                        UIImage(named: "sponsor_platinum_symantec")!,
                        UIImage(named: "sponsor_platinum_riot-games")!,
                        UIImage(named: "sponsor_platinum_tdl")!,
                        UIImage(named: "sponsor_platinum_folens")!],
                       goldImages: [
                        UIImage(named: "sponsor_gold_1_virgin_media")!,
                        UIImage(named: "sponsor_gold_dublin_council")!,
                        UIImage(named: "sponsor_gold_accenture")!,
                        UIImage(named: "sponsor_gold_lit-reverse")!],
                       goldLowerImages: [
                        UIImage(named: "sponsor_gold_workday")!,
                        UIImage(named: "sponsor_gold_zalando")!,
                        UIImage(named: "sponsor_gold_cf")!,
                        UIImage(named: "sponsor_gold_hmh")!],
                       supporterImages: [
                        UIImage(named: "sponsor_spon_dog")!,
                        UIImage(named: "sponsor_spon_aa")!,
                        UIImage(named: "sponsor_spon_1Plus")!,
                        UIImage(named: "sponsor_gold_failte-ireland")!
                        ],
                       silverTitle: NSLocalizedString("sponsor.silver.title", tableName: "Sponsors", comment: ""),
                       bronzeTitle: NSLocalizedString("sponsor.bronze.title", tableName: "Sponsors", comment: ""),
                       educationTitle: NSLocalizedString("sponsor.education.title", tableName: "Sponsors", comment: ""),
                       silverImages: [
                        image,
                        UIImage(named: "sponsor_silver_cartawler")!,
                        UIImage(named: "sponsor_silver_twitter")!,
                        UIImage(named: "sponsor_silver_zendesk")!,
                        image
                       ],
                       bronzeImages: [
                        image,
                        UIImage(named: "sponsor_bronze_barnados")!,
                        UIImage(named: "sponsor_bronze_ioe")!,
                        UIImage(named: "sponsor_bronze_mhc")!,
                        image
                       ],
                       educationImages: [
                        image,
                        UIImage(named: "sponsor_edu_dcu")!,
                        UIImage(named: "sponsor_gold_coderdojo")!,
                        image
                       ]
            )
            ] as [Component]
    }
}
