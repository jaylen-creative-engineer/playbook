//
//  PostModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/16/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class PostModel : Object {
    @objc dynamic var postId = UUID().uuidString
    @objc dynamic var thumbnailUrl : String?
    @objc dynamic var videoUrl : String?
    @objc dynamic var _description : String?
    @objc dynamic var user : UserModel!
    
    let engagements = LinkingObjects(fromType: PostEngagementsModel.self, property: "post")
    
    override static func primaryKey() -> String? {
        return "postId"
    }
    
    convenience init(thumbnailUrl : String?, videoUrl : String?, _description : String?, user : UserModel) {
        self.init()
        self.thumbnailUrl = thumbnailUrl
        self.videoUrl = videoUrl
        self._description = _description
        self.user = user
    }
}
