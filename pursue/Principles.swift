//
//  Principles.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Principles {
    let principleId : String
    let user : User
    let principleDescription : String
    let photoUrl : String
    let created_at : String
    
    var isVisible = true

    init(principleId : String, user : User, dictionary : [String : Any]){
        self.principleId = principleId
        self.user = user
        self.principleDescription = dictionary["principleDescription"] as? String ?? ""
        self.photoUrl = dictionary["photoUrl"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
