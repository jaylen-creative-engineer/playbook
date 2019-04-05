//
//  PostEngagementsModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class PostEngagementsModel : Object {
    @objc dynamic var user : UserModel!
    @objc dynamic var post : PostModel!
    @objc dynamic var is_saved = false
    @objc dynamic var is_reported = false
    @objc dynamic var has_clapped = false
    @objc dynamic var created_at = Date().timeIntervalSince1970
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    
    func setCompoundUser(user : UserModel){
        self.user = user
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundPost(post : PostModel){
        self.post = post
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: user))\(String(describing: post))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(user : UserModel, post : PostModel) {
        self.init()
        self.user = user
        self.post = post
    }
    
    func toggleSave() {
        ((try? realm?.write {
            is_saved = !is_saved
        }) as ()??)
    }
    
    func toggleReported() {
        ((try? realm?.write {
            is_reported = !is_reported
        }) as ()??)
    }
}
