//
//  User.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

struct User : Decodable {
    
    let userId : String?
    let username : String?
    let fullname : String?
    let photoUrl : String?
    let bio : String?
    let email : String?
    let followees : [Follower]
    let pursuits : [Pursuit]
    let following_count : Int?
    let followers_count : Int?
}
