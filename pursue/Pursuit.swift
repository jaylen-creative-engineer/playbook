//
//  Pursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Pursuit : Decodable {
    
    let pursuitId : String?
    let user : [User]
    let contentUrl : String?
    let thumbnailUrl : String?
    let pursuitDescription : String?
    let created_at : String?
    var is_visible = true
    var is_liked = false
    var is_saved = false
    var is_public = true
}
