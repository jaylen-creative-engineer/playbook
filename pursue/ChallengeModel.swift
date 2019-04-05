//
//  ChallengeModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/17/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class ChallengeModel : Object {
    @objc dynamic var challengeId = UUID().uuidString
    @objc dynamic var challenge_title : String?
    @objc dynamic var created_at = Date().timeIntervalSince1970
    @objc dynamic var last_updated = Date().timeIntervalSince1970
    @objc dynamic var start_date = Date().timeIntervalSince1970
    @objc dynamic var end_date : Date!
    @objc dynamic var user : UserModel!
    
    var interest = List<InterestsModel>()
    var rules = List<RulesModel>()
    var actionItems = List<ActionItemsModel>()
    
    let challengers = LinkingObjects(fromType: ChallengeEngagementsModel.self, property: "challenge")

    
    override static func primaryKey() -> String? {
        return "challengeId"
    }
    
    convenience init(challenge_title : String?, end_date : Date, user : UserModel) {
        self.init()
        self.challenge_title = challenge_title
        self.end_date = end_date
        self.user = user
    }
}
