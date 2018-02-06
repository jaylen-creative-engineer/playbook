//
//  FooUser.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct FooUser {
    
    let uid : String
    let email : String
    let username : String
    let fullname : String
    let profileImageUrl : String?
    
    init(uid: String, dictionary : [String : Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.uid = uid
        self.profileImageUrl = dictionary["profileImageURL"] as? String ?? ""
    }
}
