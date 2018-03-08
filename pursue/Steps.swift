//
//  Steps.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Steps {
    
    let stepId : String
    let pursuitId : String
    let stepDescription : String
    let contentUrl : String
    let thumbnailUrl : String
    let user : User
    let created_at : String
    
    var is_visible = true
    var is_liked = false
    var is_saved = false
    
    init(user : User, dictionary : [String : Any]){
        self.user = user
        self.stepId = dictionary["stepId"] as? String ?? ""
        self.contentUrl = dictionary["contentUrl"] as? String ?? ""
        self.thumbnailUrl = dictionary["thumbnailUrl"] as? String ?? ""
        self.pursuitId = dictionary["pursuitId"] as? String ?? ""
        self.stepDescription = dictionary["stepDescription"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
