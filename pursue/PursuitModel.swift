//
//  PursuitModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/17/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class PursuitModel : Object {
    @objc dynamic var pursuitId = UUID().uuidString
    @objc dynamic var user : UserModel!
    @objc dynamic var _description : String?
    @objc dynamic var created_at = Date().timeIntervalSince1970
    @objc dynamic var last_updated = Date().timeIntervalSince1970
    
    let engagements = LinkingObjects(fromType: PursuitEngagementsModel.self, property: "pursuit")
    
    var interests = List<InterestsModel>()
    var actionItems = List<ActionItemsModel>()
    var checkIns = List<CheckInModel>()
    var goals = List<GoalModel>()
    var team = List<TeamModel>()
    var sendTo = List<SendPursuitModel>()
    
    //MARK: - Grouping of actionItems by 24 hours
    
    override static func primaryKey() -> String? {
        return "pursuitId"
    }
    
    convenience init(user : UserModel, _description : String?) {
        self.init()
        self.user = user
        self._description = _description
    }
}
