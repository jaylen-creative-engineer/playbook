//
//  User.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

struct User {
    
    let userId : String
    let username : String
    let fullname : String
    let profileImageUrl : String
    let bio : String
    let email : String
    
    init(userId : String, dictionary : [String : Any]){
        self.userId = userId
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
   
}
