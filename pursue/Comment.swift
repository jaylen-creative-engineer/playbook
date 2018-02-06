//
//  Comment.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Comment {
    let commentId : String
    let user : User
    let comment_text : String
    let created_at : String
    
    init(commentId : String, user : User, dictionary : [String : Any]){
        self.commentId = commentId
        self.user = user
        self.comment_text = dictionary["comment_text"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
