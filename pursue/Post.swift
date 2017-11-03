//
//  Post.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

struct Post {
    
    var id : String?
    var hasLiked : Bool = false
    let user : User
    let imageURL : String
    let creationDate : Date
    let caption : String
    
    init(user: User, dictionary: [String: Any]){
        self.user = user
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
    
}
