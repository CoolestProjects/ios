//
//  CPADeeplinkManager.swift
//  CoolestProjects
//
//  Created by Rich on 14/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit
import SWRevealViewController

class CPADeeplinkManager: NSObject {

    static let DeeplinkMappings = ["speakers":"speakersNavViewController", "stages":"stagesNavViewController"]
    static let DeeplinkPageKey = "deeplink_page"
    static let DeeplinkKeyPrefix = "deeplink_"
    
    static func handleDeeplinkUserInfoForRootViewController(userInfo :[String: String], viewController :UIViewController ) {
        
        let deeplinkKey = userInfo[DeeplinkPageKey]
        
        if let deeplinkScreenIdentifier = DeeplinkMappings[deeplinkKey!] {
            
            let revealViewController = viewController as! SWRevealViewController
            let storyboard = revealViewController.storyboard
            
            if let deeplinkNavigationController = storyboard?.instantiateViewController(withIdentifier: deeplinkScreenIdentifier) as! UINavigationController? {
                
                if let topViewController = deeplinkNavigationController.topViewController as! BaseViewController? {
                    
                    topViewController.deeplinkData = getAllDeeplinkKeysAsMap(userInfo: userInfo)
                    revealViewController.setFront(deeplinkNavigationController, animated: true)
                }
            }
        }
    }
    
    static func getAllDeeplinkKeysAsMap(userInfo: [String: String]) -> [String: String] {
        
        let allDeeplinks = userInfo.filter { (key, value) -> Bool in
            key.contains(DeeplinkKeyPrefix) && key != DeeplinkPageKey
        }.dictionary()
        
        let sanitisedDeeplinks = allDeeplinks.map{ (key, value) in
            (key.replacingOccurrences(of: DeeplinkKeyPrefix, with: ""), value)
        }.dictionary()

        return sanitisedDeeplinks
    }
}

//possibly I completely misunderstood how swift works but I wanted to filter and map a [String: String] and the result was a [(String: String)], this code fixes that and returns a [String: String] again, is there an easier way?
extension Array {
    func dictionary<K: Hashable, V>() -> [K: V] where Element == Dictionary<K, V>.Element {
        var dictionary = [K: V]()
        for element in self {
            dictionary[element.key] = element.value
        }
        return dictionary
    }
}
