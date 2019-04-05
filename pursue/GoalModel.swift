//
//  GoalModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class GoalModel : Object {
    
    @objc dynamic var goalId = UUID().uuidString
    @objc dynamic var goalTitle : String?
    @objc dynamic var interest : InterestsModel?
    
    override static func primaryKey() -> String {
        return "goalId"
    }
    
    convenience init(goalTitle : String?) {
        self.init()
        self.goalTitle = goalTitle
    }
}
