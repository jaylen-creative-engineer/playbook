//
//  QuestionModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/24/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import Foundation
import RealmSwift

class QuestionModel : Object {
    @objc dynamic var questionId = UUID().uuidString
    @objc dynamic var thumbnailUrl : String?
    @objc dynamic var videoUrl : String?
    @objc dynamic var _description : String?
    @objc dynamic var user : UserModel?
    
    let engagements = LinkingObjects(fromType: QuestionEngagementsModel.self, property: "question")
    let answers = LinkingObjects(fromType: AnswerModel.self, property: "question")
    
    override static func primaryKey() -> String? {
        return "questionId"
    }
    
    convenience init(thumbnailUrl : String?, videoUrl : String?, _description : String?, user : UserModel?) {
        self.init()
        self.thumbnailUrl = thumbnailUrl
        self.videoUrl = videoUrl
        self._description = _description
        self.user = user
    }
}
