//
//  UserDetails.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/24/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct UserDetails : Decodable {
    
    let userId : String?
    let username : String?
    let fullname : String?
    let photoUrl : String?
    let bio : String?
}
