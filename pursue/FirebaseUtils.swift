//
//  FirebaseUtils.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    
    static func fetchUserWithUID(uid: String, completion: @escaping (FooUser) -> ()) {
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            
            let user = FooUser(uid: uid, dictionary: userDictionary)
            completion(user)
            
        }) { (err) in
            
            print("Failed to fetch user", err)
        }
    }
    
}
