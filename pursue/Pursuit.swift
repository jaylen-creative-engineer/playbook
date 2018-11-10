//
//  Pursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Pursuit : Decodable {
    
    let pursuitId : Int?
    let posts : [Post]?
    let postId : Int?
    let contentUrl : String?
    let thumbnailUrl : String?
    let interestId : Int?
    let description : String?
    let created_at : String?
    var is_visible : Int?
    var is_liked : Int?
    var is_saved : Int?
    var is_public : Int?
}
