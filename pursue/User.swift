//
//  User.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

struct User {
    
    let uid : String
    let username : String
    let fullname : String
    let profileImageURL : String
    
    init(uid: String, dictionary : [String : Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.uid = uid
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
    }
}
