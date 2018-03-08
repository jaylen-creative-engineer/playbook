//
//  PrincipleComment.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/7/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct PrincipleComment {
    let commentId : String
    let principleId : String
    let user : User
    let comment_text : String
    let created_at : String
    
    init(user : User, dictionary : [String : Any]){
        self.user = user
        self.commentId = dictionary["commentId"] as? String ?? ""
        self.principleId = dictionary["principleId"] as? String ?? ""
        self.comment_text = dictionary["comment_text"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
