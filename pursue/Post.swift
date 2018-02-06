//
//  Post.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

struct Post {
    var postId : String
    let user : User
    let photoUrl : String
    let created_at : String
    let postDescription : String?
    var is_visible = true
    
    init(user : User, dictionary : [String : Any]) {
        self.user = user
        self.postId = dictionary["postId"] as? String ?? ""
        self.photoUrl = dictionary["photoUrl"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
        self.postDescription = dictionary["postDescription"] as? String ?? ""
    }
}
