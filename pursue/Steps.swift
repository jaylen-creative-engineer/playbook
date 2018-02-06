//
//  Steps.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Steps {
    
    let stepId : String
    let label : String
    let created_at : String
    let is_visible = true
    let is_complete = false
    
    init(stepId : String, dictionary : [String : Any]){
        self.stepId = stepId
        self.label = dictionary["label"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? String ?? ""
    }
}
