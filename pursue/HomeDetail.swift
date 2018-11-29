//
//  HomeDetail.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct HomeDetail : Decodable {
    
    let posts : [Post]?
    let days : [Post]?
    let responses : [Post]?
    let trying : [Post]?
    let team : [User]?
    let key_posts : [Post]?
}
