//
//  SendPursuitModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class SendPursuitModel : Object {
    
    @objc dynamic var recipent : UserModel!
    @objc dynamic var pursuit : PursuitModel!
    @objc dynamic var is_tried = false
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    
    func setCompoundUser(recipent : UserModel){
        self.recipent = recipent
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundPursuit(pursuit : PursuitModel){
        self.pursuit = pursuit
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: recipent))\(String(describing: pursuit))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }

    convenience init(recipent : UserModel, pursuit : PursuitModel, is_tried : Bool) {
        self.init()
        self.recipent = recipent
        self.pursuit = pursuit
        self.is_tried = is_tried
    }
}
