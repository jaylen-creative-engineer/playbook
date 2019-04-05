//
//  AddedModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class AddedModel : Object {
    
    @objc dynamic var added : UserModel!
    @objc dynamic var addee : UserModel!
    @objc dynamic var is_added = true
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    @objc dynamic var created_at = Date().timeIntervalSince1970
    
    func setCompoundUser(added : UserModel){
        self.added = added
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundAddee(addee : UserModel){
        self.addee = addee
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: added))\(String(describing: addee))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(added : UserModel, addee : UserModel) {
        self.init()
        self.added = added
        self.addee = addee
    }
    
    func toggleAdded(){
        ((try? realm?.write {
            is_added = !is_added
        }) as ()??)
    }
}
