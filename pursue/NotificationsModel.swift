//
//  NotificationsModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/19/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class NotificationsModel : Object {
    
    @objc dynamic var notificationsId = UUID().uuidString
    @objc dynamic var user : UserModel!
    @objc dynamic var _description : String?
    @objc dynamic var pursuits : PursuitModel?
    @objc dynamic var challenge : ChallengeModel?
    @objc dynamic var added : AddedModel?
    @objc dynamic var created_at = Date().timeIntervalSince1970
}
