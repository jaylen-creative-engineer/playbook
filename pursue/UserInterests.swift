//
//  UserInterests.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/6/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct UserInterests {
    let interestIds : [Dictionary<String,AnyObject>]
    
    init(interestIds : [Dictionary<String,AnyObject>]) {
        self.interestIds = interestIds
    }
}
