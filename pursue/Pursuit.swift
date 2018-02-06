//
//  Pursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Pursuit {
    
    let pursuitId : String
    let user : User
    let pursuitDescription : String
    let photoUrl : String
    let created_at : String
    
    let is_visible = true
    
    init(pursuitId : String, user : User, dictionary : [String : Any]){
        self.pursuitId = pursuitId
        self.user = user
        self.pursuitDescription = dictionary["pursuitDescription"] as? String ?? ""
        self.photoUrl = dictionary["photoUrl"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
