//
//  BlockUserModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/24/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class BlockUserModel : Object {
    
    @objc dynamic var blocker : UserModel!
    @objc dynamic var blockee : UserModel!
    @objc dynamic var is_blocked = true
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    
    func setCompoundUser(blocker : UserModel){
        self.blocker = blocker
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundBlockee(blockee : UserModel){
        self.blockee = blockee
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: blocker))\(String(describing: blockee))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(blocker : UserModel, blockee : UserModel) {
        self.init()
        self.blocker = blocker
        self.blockee = blockee
    }
    
    func toggleBlock(){
        ((try? realm?.write {
            is_blocked = !is_blocked
        }) as ()??)
    }
}
