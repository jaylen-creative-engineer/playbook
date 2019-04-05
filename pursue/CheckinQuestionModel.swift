//
//  QuestionModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class CheckinQuestionModel : Object {
    
    @objc dynamic var checkinQuestionId = UUID().uuidString
    @objc dynamic var question : String!
    var answers = List<CheckinAnswersModel>()
    
    override static func primaryKey() -> String? {
        return "checkinQuestionId"
    }
    
    convenience init(question : String) {
        self.init()
        self.question = question
    }
}
