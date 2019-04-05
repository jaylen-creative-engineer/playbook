//
//  RealmConnection.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/24/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    func connectToRealm() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
}
