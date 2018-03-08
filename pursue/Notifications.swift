//
//  Notifications.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Notifications {
    
    let userId : String
    let text : String
    let fullname : String
    let photoUrl : String
    
    init(dictionary : [String : Any]){
        self.userId = dictionary["userId"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.photoUrl = dictionary["photoUrl"] as? String ?? ""
    }
}
