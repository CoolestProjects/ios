//
//  CPADeeplinkManager.swift
//  CoolestProjects
//
//  Created by Rich on 14/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

struct DeepLinkKeys {
    static let deepLinkPageKey = "deeplink_page"
}

protocol DeepLinkParser {

    func parse(userInfo: [AnyHashable: Any]) -> (String, Any)?

}

struct HallDeepLinkInfo {
    let hallId: String
    let hallActivity: String
}

struct HallDeepLinkParser: DeepLinkParser {

    static let notficationName = "HallDeepLinkNotification"

    // /halls/iot/workshop1
    func parse(userInfo: [AnyHashable: Any]) -> (String, Any)? {
        guard let deepLinkPage = userInfo[DeepLinkKeys.deepLinkPageKey] as? String
            else { return nil }

        let components = deepLinkPage.components(separatedBy: "/").filter { !$0.isEmpty }

        if components.count == 3
            && components[0] == "halls"
            && ["panels", "workshop1", "workshop2"].contains(components[2]) {
            return (HallDeepLinkParser.notficationName, HallDeepLinkInfo(hallId: components[1], hallActivity: components[2]))
        } else {
            return nil
        }
    }

}

class CPADeeplinkManager: NSObject {

    private static let parsers: [DeepLinkParser] = [HallDeepLinkParser()]

    static func handleDeeplink(userInfo: [AnyHashable:Any]) {

        let deepLinkData = parsers.flatMap { $0.parse(userInfo: userInfo) }.first
        if let deepLinkData = deepLinkData {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: deepLinkData.0),
                object: self,
                userInfo: ["payload": deepLinkData.1])
        }

    }

}
