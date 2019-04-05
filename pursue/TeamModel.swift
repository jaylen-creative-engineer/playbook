//
//  TeamModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class TeamModel : Object {
    
    @objc dynamic var user : UserModel!
    @objc dynamic var pursuit : PursuitModel!
    @objc dynamic var is_teamMember = true
    
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    
    func setCompoundUser(user : UserModel){
        self.user = user
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundPursuit(pursuit : PursuitModel){
        self.pursuit = pursuit
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: user))\(String(describing: pursuit))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(user : UserModel, pursuit : PursuitModel, is_teamMember : Bool) {
        self.init()
        self.user = user
        self.pursuit = pursuit
        self.is_teamMember = is_teamMember
    }
}
