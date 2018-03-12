//
//  StepsComment.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/7/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct StepsComment {
    let commentId : String
    let stepId : String
    let user : User
    let comment_text : String
    let created_at : String
    
    init(user : User, dictionary : [String : Any]){
        self.user = user
        self.commentId = dictionary["commentId"] as? String ?? ""
        self.stepId = dictionary["stepId"] as? String ?? ""
        self.comment_text = dictionary["comment_text"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
