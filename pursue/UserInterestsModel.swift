//
//  UserInterestsModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/17/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class UserInterestsModel : Object {
    @objc dynamic var interest : InterestsModel?
    @objc dynamic var user : UserModel?
    @objc dynamic var is_selected = true
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    
    func setCompoundUser(user : UserModel){
        self.user = user
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundInterest(interest : InterestsModel){
        self.interest = interest
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: user))\(String(describing: interest))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(interest : InterestsModel, user : UserModel) {
        self.init()
        self.interest = interest
        self.user = user
    }
    
    func toggleSelected() {
        ((try? realm?.write {
            is_selected = !is_selected
        }) as ()??)
    }
}
