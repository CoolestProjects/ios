//
//  CPADeeplinkManager.swift
//  CoolestProjects
//
//  Created by Rich on 14/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class CPADeeplinkManager: NSObject {

    private static let deeplinkMappings = ["speakers":"speakersNavViewController", "stages":"stagesNavViewController"]
    private static let deeplinkPageKey = "deeplink_page"
    private static let deeplinkKeyPrefix = "deeplink_"
    
    static func handleDeeplink(userInfo: [AnyHashable:Any], rootViewController: UIViewController) {
//
//        guard let userInfo = userInfo as? [String:String],
//            let deeplinkPage = userInfo[deeplinkPageKey],
//            let deeplinkScreenIdentifier = deeplinkMappings[deeplinkPage],
//            let deeplinkNavigationController = rootViewController.storyboard?.instantiateViewController(withIdentifier: deeplinkScreenIdentifier) as? UINavigationController,
//            let topViewController = deeplinkNavigationController.topViewController as? BaseViewController,
//            let revealViewController = rootViewController as? SWRevealViewController else {
//            return
//        }
//
//        topViewController.deeplinkData = getAllDeeplinkKeys(userInfo)
//        revealViewController.setFront(deeplinkNavigationController, animated: true)
    }
    
    private static func getAllDeeplinkKeys(_ userInfo: [String:String]) -> [String:String] {
        
        let allDeeplinks = userInfo.filter { (key, value) -> Bool in
            key.contains(deeplinkKeyPrefix) && key != deeplinkPageKey
        }.dictionary()
        
        let sanitisedDeeplinks = allDeeplinks.map{ (key, value) in
            (key.replacingOccurrences(of: deeplinkKeyPrefix, with: ""), value)
        }.dictionary()

        return sanitisedDeeplinks
    }
}

extension Array {
    func dictionary<K: Hashable, V>() -> [K: V] where Element == Dictionary<K, V>.Element {
        var dictionary = [K: V]()
        for element in self {
            dictionary[element.key] = element.value
        }
        return dictionary
    }
}
