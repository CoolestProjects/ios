//
//  ScheduleService.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 25/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import FirebaseDatabase

typealias HallsCallback = ([Hall]?) -> Void

typealias HallCallback = (Hall?) -> Void


protocol ScheduleService {

    func halls(callback: @escaping HallsCallback)

    func hall(with hallId: String, callback: @escaping HallCallback)

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

    fileprivate func findAllHalls(callback: @escaping ([Hall]?) -> Void) {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var halls: [Hall]? = nil
            if let json = snapshot.value as? [[String:Any]] {
                halls = [Hall].from(jsonArray: json)
            }
            callback(halls)
        }, withCancel: { (error) in
            print("Error: \(error)")
            callback(nil)
        })
    }

}

extension ScheduleServiceImpl: ScheduleService {

    func halls(callback: @escaping HallsCallback) {
        findAllHalls() { (halls) in
            callback(halls)
        }
    }

    func hall(with hallId: String, callback: @escaping HallCallback) {
        findHall(with: hallId) { (hall) in
            callback(hall)
        }
    }

}
