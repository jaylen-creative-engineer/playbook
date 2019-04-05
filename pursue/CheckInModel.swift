//
//  CheckInModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class CheckInModel : Object {
    
    @objc dynamic var checkInId = UUID().uuidString
    @objc dynamic var _description : String?
    @objc dynamic var checkInDay : Date?
    @objc dynamic var is_completed = false
    
    var questions = List<CheckinQuestionModel>()
    var answers = List<CheckinAnswersModel>()
    
    override static func primaryKey() -> String? {
        return "checkInId"
    }
    
    convenience init(_description : String?, is_completed : Bool) {
        self.init()
        self._description = _description
        self.is_completed = is_completed
    }
}
