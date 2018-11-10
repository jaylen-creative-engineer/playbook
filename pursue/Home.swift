//
//  Home.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Home : Decodable {
    
    let userId : Int?
    let username : String?
    let photoUrl : String?
    let posts : [Post]?
}
