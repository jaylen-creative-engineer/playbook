//
//  ScheduleModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/26/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class ScheduleModel: Object {
    
    @objc dynamic var pursuit : PursuitModel?
    @objc dynamic var scheduleTitle : String?
    @objc dynamic var is_selected = false
    
}
