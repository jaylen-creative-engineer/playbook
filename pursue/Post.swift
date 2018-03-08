//
//  Post.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

struct Post {
    let postId : String
    let pursuitId : String
    let user : User
    let contentUrl : String
    let thumbnailUrl : String
    let created_at : String
    var is_visible = true
    var is_liked = false
    var is_saved = false
    
    init(user : User, dictionary : [String : Any]) {
        self.user = user
        self.pursuitId = dictionary["pursuitId"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.contentUrl = dictionary["contentUrl"] as? String ?? ""
        self.thumbnailUrl = dictionary["thumbnailUrl"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
