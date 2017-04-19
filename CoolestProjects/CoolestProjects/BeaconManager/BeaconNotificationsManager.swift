//
//  BeaconNotificationsManager.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 18/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation

class BeaconNotificationsManager: NSObject {

    static let sharedInstance = BeaconNotificationsManager()

    private override init() {
        super.init()
        beaconManager.delegate = self
    }

    func requestAuthorization() {
        beaconManager.requestAlwaysAuthorization()
    }

    private let beaconManager = ESTBeaconManager()
}

extension BeaconNotificationsManager: ESTBeaconManagerDelegate {

    func beaconManager(_ manager: Any, didStartMonitoringFor region: CLBeaconRegion) {
        print("Did start monitoring for region \(region)")
    }

    func beaconManager(_ manager: Any, monitoringDidFailFor region: CLBeaconRegion?, withError error: Error) {
        print("Monitoring failed for region: \(region?.identifier ?? "(unknown)"). The error was: \(error).")
    }

    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("Did enter region \(region).")
    }

    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("Did exit region \(region).")
    }

    func beaconManager(_ manager: Any, didChange status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            print("Location Services are disabled for this app.")
        }
    }

}

