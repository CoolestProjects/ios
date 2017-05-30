//
//  HomeViewModel.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 01/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel {

    var tableViewData = [Component]()
    
    init() {
        createTableViewData(showBluetoothView: false)
    }
    
    func setBluetoothEnabled(bluetoothEnabled : Bool) {
        createTableViewData(showBluetoothView: bluetoothEnabled)
    }
    
    private func createTableViewData(showBluetoothView: Bool) {
        tableViewData = [
            BlurbBox(title: NSLocalizedString("date.tilte", tableName: "Home", comment: "")),
        ]
        
        if (showBluetoothView) {
            tableViewData += [BluetoothBox()]
        }
        
        tableViewData += [
            ContentViewModel(
                title: NSLocalizedString("event-times.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("event-times.body", tableName: "Home", comment: ""),
                icon: UIImage(named: "section_icon_event_times")
            ),
            ContentViewModel(
                title: NSLocalizedString("parking.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("parking.body", tableName: "Home", comment: ""),
                icon: UIImage(named: "section_icon_parking")
            ),
            ContentViewModel(
                title: NSLocalizedString("food.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("food.body", tableName: "Home", comment: ""),
                icon: UIImage(named: "section_icon_food")
            ),
            SponsorBox(title: NSLocalizedString("sponsor.title", tableName: "Home", comment: ""),
                       diamondImages: [
                        UIImage(),
                        UIImage(named: "sponsor_diamond_intel")!,
                        UIImage(named: "sponsor_diamond_microsoft")!,
                        UIImage()],
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
                        //TODO: add dublin city council logo when available
                        UIImage(named: "sponsor_gold_failte-ireland")!,
                        UIImage(named: "sponsor_gold_accenture")!],
                       goldLowerImages: [
                        UIImage(named: "sponsor_gold_lit-reverse")!,
                        UIImage(named: "sponsor_gold_workday")!,
                        UIImage(named: "sponsor_gold_zalando")!,
                        UIImage(named: "sponsor_gold_cf")!,]
            ),
            ContentViewModel(
                title: NSLocalizedString("opennet.title", tableName: "Home", comment: ""),
                body: NSLocalizedString("opennet.body", tableName: "Home", comment: ""),
                icon: nil
            )] as [Component]
    }
}
