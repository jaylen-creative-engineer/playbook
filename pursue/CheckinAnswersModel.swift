//
//  AnswersModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class CheckinAnswersModel : Object {
    
    @objc dynamic var checkinAnswerId = UUID().uuidString
    @objc dynamic var answer_text : String!
    @objc dynamic var is_selected = true
    
    override static func primaryKey() -> String? {
        return "checkinAnswerId"
    }
    
    convenience init(answer_text : String, is_selected : Bool) {
        self.init()
        self.answer_text = answer_text
        self.is_selected = is_selected
    }
}
