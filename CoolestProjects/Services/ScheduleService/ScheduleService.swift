//
//  ScheduleService.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 25/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import FirebaseDatabase

typealias HallCallback = (Hall?) -> Void

typealias PanelsCallback = ([Panel]?) -> Void

typealias WorkshopsCallback = ([Workshop]?) -> Void

protocol ScheduleService {

    func hall(with hallId: String, callback: @escaping HallCallback)

    func allPanels(hallId: String, callback: @escaping PanelsCallback)

    //func allWorkshops(hallId: String, callback: @escaping WorkshopsCallback)

}

class ScheduleServiceImpl {

    fileprivate let ref: FIRDatabaseReference

    init() {
        ref = FIRDatabase.database().reference().child("halls")
        ref.keepSynced(true)
    }

    /*
     TODO: to access directly the list of panels and workshop for a given hall
     e.g. halls/iot/panels or halls/iot/workshops
     firebase should have a structure like this one

     {
       "halls": {
         "iot": {
           "panels": [{ }, { }],
           "workshop": [{ }, { }]
          },
          "steam": {
            "panels": [{ }, { }],
            "workshop": [{ }, { }]
          }
        }
     }

     */

    fileprivate func findHall(with hallId: String, callback: @escaping (Hall?) -> Void) {
        let query = ref.queryOrdered(byChild: "hallId").queryEqual(toValue: hallId)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            var hall: Hall? = nil

            let enumerator = snapshot.children
            while let childSnapshot = enumerator.nextObject() as? FIRDataSnapshot {
                if let json = childSnapshot.value as? [String:Any] {
                    hall = Hall(json: json)
                }
            }

            callback(hall)
            
        }, withCancel: { (error) in
            print("Error: \(error)")
            callback(nil)
        })
    }

}

extension ScheduleServiceImpl: ScheduleService {

    func hall(with hallId: String, callback: @escaping HallCallback) {
        findHall(with: hallId) { (hall) in
            callback(hall)
        }
    }

    func allPanels(hallId: String, callback: @escaping PanelsCallback) {
        findHall(with: hallId) { (hall) in
            callback(hall?.panels)
        }
    }

//    func allWorkshops(hallId: String, callback: @escaping WorkshopsCallback) {
//        findHall(hallId: hallId) { (hall) in
//            callback(hall?.workshops)
//        }
//    }

}
