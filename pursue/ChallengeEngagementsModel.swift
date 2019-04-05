//
//  ChallengeEngagementsModels.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class ChallengeEngagementsModel : Object {
    @objc dynamic var user : UserModel!
    @objc dynamic var challenge : ChallengeModel!
    @objc dynamic var is_reported = false
    @objc dynamic var has_joined = false
    @objc dynamic var created_at = Date().timeIntervalSince1970
    @objc dynamic lazy var compoundKey : String = self.compoundKeyValue()
    
    let position = RealmOptional<Int>()
    
    func setCompoundUser(user : UserModel){
        self.user = user
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundChallenge(challenge : ChallengeModel){
        self.challenge = challenge
        compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(String(describing: user))\(String(describing: challenge))"
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(user : UserModel, challenge : ChallengeModel, is_reported : Bool, has_joined : Bool) {
        self.init()
        self.user = user
        self.challenge = challenge
        self.is_reported = is_reported
        self.has_joined = has_joined
    }
}
