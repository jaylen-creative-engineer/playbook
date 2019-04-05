//
//  ActionItemsModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class ActionItemsModel : Object {
    
    @objc dynamic var actionId = UUID().uuidString
    @objc dynamic var is_completed = false
    @objc dynamic var is_used = false
    @objc dynamic var is_discarded = false
    @objc dynamic var _description : String?
    @objc dynamic var goal : GoalModel?
    @objc dynamic var created_at = Date().timeIntervalSince1970
    
    let position = RealmOptional<Int>()
    var posts = List<PostModel>()
    
    override static func primaryKey() -> String? {
        return "actionId"
    }
    
    convenience init(_description : String?, goal : GoalModel?) {
        self.init()
        self._description = _description
        self.goal = goal
    }
}
