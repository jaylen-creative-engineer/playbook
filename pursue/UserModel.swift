//
//  UserModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/16/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel : Object {
    @objc dynamic var userId = UUID().uuidString
    @objc dynamic var username : String?
    @objc dynamic var fullname : String?
    @objc dynamic var bio : String?
    @objc dynamic var photoUrl : String?
    @objc dynamic var email : String?
    @objc dynamic var created_at = Date().timeIntervalSince1970

        
    let pursuits = LinkingObjects(fromType: PursuitModel.self, property: "user")
    let challenges = LinkingObjects(fromType: ChallengeModel.self, property: "user")
    let added = LinkingObjects(fromType: AddedModel.self, property: "addee")
    
    override static func primaryKey() -> String? {
        return "username"
    }
    
    convenience init(username : String?, fullname : String?, bio : String?, photoUrl : String?, email : String?) {
        self.init()
        self.username = username
        self.fullname = fullname
        self.bio = bio
        self.photoUrl = photoUrl
        self.email = email
    }
}
