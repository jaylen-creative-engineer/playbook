//
//  RulesModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/17/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class RulesModel : Object {
    @objc dynamic var rulesId = UUID().uuidString
    @objc dynamic var _description : String?
    
    override static func primaryKey() -> String? {
        return "rulesId"
    }
    
    convenience init(_description : String?) {
        self.init()
        self._description = _description
    }
}
