//
//  QuestionEngagementsModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/24/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class QuestionEngagementsModel : Object {
    @objc dynamic var user : UserModel!
    @objc dynamic var question : QuestionModel!
    @objc dynamic var is_reported = false
    @objc dynamic var is_solved = false
    @objc dynamic var has_clapped = false
    @objc dynamic var created_at = Date().timeIntervalSince1970
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    
    func setCompoundUser(user : UserModel){
        self.user = user
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundQuestion(question : QuestionModel){
        self.question = question
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: user))\(String(describing: question))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(user : UserModel, question : QuestionModel) {
        self.init()
        self.user = user
        self.question = question
    }
}
