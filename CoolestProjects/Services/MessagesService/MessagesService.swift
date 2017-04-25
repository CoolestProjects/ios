//
//  MessagesService.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 24/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import Firebase
import Gloss

typealias AllMessagesCallback = ([Message]?) -> Void

typealias MessageForRegionCallback = (Message?) -> Void

protocol MessagesService {

    func allMessages(_ callback: @escaping AllMessagesCallback)

    func messageForRegion(_ regionId: String, callback: @escaping MessageForRegionCallback)

}

class MessagesServiceImpl {

    init() {
        ref = FIRDatabase.database().reference().child("messages")
        noOpHandle = ref.observe(.value, with: { (_) in })
    }

    deinit {
        ref.removeObserver(withHandle: noOpHandle)
    }

    fileprivate let ref: FIRDatabaseReference
    fileprivate let noOpHandle: FIRDatabaseHandle

}

extension MessagesServiceImpl: MessagesService {

    func allMessages(_ callback: @escaping AllMessagesCallback) {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var messages: [Message]? = nil
            if let json = snapshot.value as? [[String:Any]] {
                messages = [Message].from(jsonArray: json)
            }
            callback(messages)
        }, withCancel: { (error) in
            print("Error: \(error)")
            callback(nil)
        })
    }

    func messageForRegion(_ regionId: String, callback: @escaping MessageForRegionCallback) {
        let query = ref.queryOrdered(byChild: "regionId").queryEqual(toValue: regionId)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            var message: Message? = nil

            let enumerator = snapshot.children
            while let childSnapshot = enumerator.nextObject() as? FIRDataSnapshot {
                if let json = childSnapshot.value as? [String:Any] {
                    message = Message(json: json)
                }
            }

            callback(message)
        }, withCancel: { (error) in
            print("Error: \(error)")
            callback(nil)
        })

    }

}
