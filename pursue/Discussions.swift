//
//  Discussions.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import Foundation

struct Discussions {
    let discussionId : String
    let user : User
    let discussionDescription : String
    let photoUrl : String
    let created_at : String
    
    var is_visible = true
    
    init(discussionId : String, user : User, dictionary : [String : Any]){
        self.discussionId = discussionId
        self.user = user
        self.discussionDescription = dictionary["discussionDescription"] as? String ?? ""
        self.photoUrl = dictionary["photoUrl"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
