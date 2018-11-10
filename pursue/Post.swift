//
//  Post.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

struct Post : Decodable {
    
    let postId : Int?
    let pursuitId : Int?
    let thumbnailUrl : String?
    let videoUrl : String?
    let posts_description : String?
    let is_keyPost : Int?
//    let created_at : Data?
}
