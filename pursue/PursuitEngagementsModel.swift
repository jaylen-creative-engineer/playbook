//
//  PostEngagementsModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/18/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class PursuitEngagementsModel : Object {
    @objc dynamic var user : UserModel!
    @objc dynamic var pursuit : PursuitModel!
    @objc dynamic var is_tried = false
    @objc dynamic var is_reported = false
    @objc dynamic var created_at = Date().timeIntervalSince1970
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
    
    convenience init(user : UserModel, pursuit : PursuitModel) {
        self.init()
        self.user = user
        self.pursuit = pursuit
    }
    
    func toggleTry() {
        ((try? realm?.write {
            is_tried = !is_tried
        }) as ()??)
    }
}
