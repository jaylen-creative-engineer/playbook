//
//  InterestsModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/16/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class InterestsModel : Object {
    @objc dynamic var interestId = UUID().uuidString
    @objc dynamic var interestName : String?
    @objc dynamic var photoUrl : String?
    
    let goals = LinkingObjects(fromType: GoalModel.self, property: "interest")
    let actionItems = LinkingObjects(fromType: ActionItemsModel.self, property: "interest")
    
    override static func primaryKey() -> String? {
        return "interestId"
    }
    
    convenience init(interestName : String?, photoUrl : String?) {
        self.init()
        self.interestName = interestName
        self.photoUrl = photoUrl
    }
}
