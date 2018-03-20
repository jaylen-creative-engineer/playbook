//
//  Steps.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Steps : Decodable {
    
    let stepId : String?
    let pursuitId : String?
    let stepDescription : String?
    let contentUrl : String?
    let thumbnailUrl : String?
    let created_at : String?
    var is_visible : Int?
    var is_liked : Int?
    var is_saved : Int?
}
