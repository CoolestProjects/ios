//
//  BluetoothAlertManager.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 13/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class BluetoothAlertManager: NSObject {

    static let sharedInstance = BluetoothAlertManager()

    /// Min time interval between two Bluetooth power off alerts
    fileprivate let alertTimeInterval: TimeInterval = 1800

    private override init() {
        super.init()
        lastAlertDate = UserDefaults.standard.value(forKey: "BluetoothPowerOffAlertDate") as? Date
    }

    func showBluetoothPowerOffAlert() {
        guard shouldShowBluetoothPowerOffAlert() else {
            return
        }

        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindowLevelAlert + 1

        let alert = UIAlertController(
            title: NSLocalizedString("bluetoothPowerOff.title", tableName: "Alerts", comment: ""),
            message: NSLocalizedString("bluetoothPowerOff.message", tableName: "Alerts", comment: ""),
            preferredStyle: .alert)

        let settingsAction = UIAlertAction(
            title: NSLocalizedString("settings", tableName: "Alerts", comment: ""),
            style: .default) { (_) in

                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: "App-Prefs:root=Bluetooth")!)
                } else {
                    UIApplication.shared.open(URL(string: "prefs:root=General&path=Bluetooth")!)
                }

                topWindow.isHidden = true
        }

        let ignoreAction = UIAlertAction(
            title: NSLocalizedString("ignore", tableName: "Alerts", comment: ""),
            style: .cancel) { (_) in
                topWindow.isHidden = true
        }

        alert.addAction(settingsAction)
        alert.addAction(ignoreAction)

        topWindow.makeKeyAndVisible()
        topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })

        lastAlertDate = Date()
    }

    fileprivate func shouldShowBluetoothPowerOffAlert() -> Bool {
        if let lastAlertDate = lastAlertDate {
            return Date().timeIntervalSince(lastAlertDate) > alertTimeInterval
        } else {
            return true
        }
    }

    fileprivate var lastAlertDate: Date? {
        didSet {
            UserDefaults.standard.set(lastAlertDate, forKey: "BluetoothPowerOffAlertDate")
        }
    }
}
