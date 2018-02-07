//
//  Interests.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Interests {
    let interestId : String
    let interestName : String
    let interestPhoto : String
    var isSelected = false
    
    init(dictionary : [String : Any]) {
        self.interestId = dictionary["interestId"] as? String ?? ""
        self.interestName = dictionary["interest_name"] as? String ?? ""
        self.interestPhoto = dictionary["interest_photo"] as? String ?? ""
    }
}
