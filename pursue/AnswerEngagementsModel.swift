//
//  AnswerEngagementsModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/26/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class AnswerEngagementsModel : Object {
    @objc dynamic var user : UserModel!
    @objc dynamic var answer : AnswerModel!
    @objc dynamic var is_reported = false
    @objc dynamic var is_accepted = false
    @objc dynamic var has_clapped = false
    @objc dynamic var created_at = Date().timeIntervalSince1970
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    
    func setCompoundUser(user : UserModel){
        self.user = user
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundAnswer(answer : AnswerModel){
        self.answer = answer
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: user))\(String(describing: answer))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(user : UserModel, answer : AnswerModel) {
        self.init()
        self.user = user
        self.answer = answer
    }
}

