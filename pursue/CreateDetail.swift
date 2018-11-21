//
//  CreateDetail.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/16/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct CreateDetail : Decodable {
    
    let team : [User]?
    let interests : [CreateInterests]?
    let pursuits : [Pursuit]?
}
