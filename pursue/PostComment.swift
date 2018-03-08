//
//  Comment.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct PostComment {
    let commentId : String
    let postId : String
    let user : User
    let comment_text : String
    let created_at : String
    
    init(user : User, dictionary : [String : Any]){
        self.user = user
        self.commentId = dictionary["commentId"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.comment_text = dictionary["comment_text"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
