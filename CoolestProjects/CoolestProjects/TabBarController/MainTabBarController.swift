//
//  MainTabBarController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 29/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    static let hallsSectionIndex = 2

    var scheduleService: ScheduleService?

    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleService = ScheduleServiceImpl()
        registerForDeepLinkNotifications()
    }

    func registerForDeepLinkNotifications() {
        registerForHallsDeepLinkNotification()
    }

    func registerForHallsDeepLinkNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleHallsDeepLinkNotification(notification:)),
            name: NSNotification.Name(rawValue: HallDeepLinkParser.notficationName),
            object: nil)
    }

    func handleHallsDeepLinkNotification(notification: Notification) {
        guard let deepLinkInfo = notification.userInfo?["payload"] as? HallDeepLinkInfo
            else { return }

        let hallActivity = deepLinkInfo.hallActivity
        scheduleService?.hall(with: deepLinkInfo.hallId) { [weak self] (hall) in
            if let hall = hall {
                self?.navigateToHall(hall, activty: hallActivity)
            }
        }

    }

    func navigateToHall(_ hall: Hall, activty: String) {
        let vc = HallActivitiesViewController(nibName: nil, bundle: nil)
        vc.hall = hall
        vc.preselectedActivity = activty
        vc.hidesBottomBarWhenPushed = true

        if let controllers = self.viewControllers,
            let nc = controllers[MainTabBarController.hallsSectionIndex] as? UINavigationController {

            var hallsSectionControllers = nc.viewControllers

            if (hallsSectionControllers.count > 1) {
                hallsSectionControllers.removeLast()
            }

            hallsSectionControllers.append(vc)

            nc.setViewControllers(hallsSectionControllers, animated: false)
            selectedIndex = MainTabBarController.hallsSectionIndex
        }
    }

}
