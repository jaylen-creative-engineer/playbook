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
    let photoUrl : String
    let bio : String
    let email : String
    
    init(dictionary : [String : Any]){
        self.userId = dictionary["userId"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.photoUrl = dictionary["photoUrl"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? "Here is some sample text that I am putting right here just to see how to bio text field looks, with some live data. Here is some sample text that I am putting right here just to see how to bio text field looks, with some live data. Here is some sample text that I am putting right here just to see how to bio text field looks, with some live data."
        self.email = dictionary["email"] as? String ?? ""
    }
   
}
