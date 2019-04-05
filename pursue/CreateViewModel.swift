//
//  CreateViewModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/23/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class CreateViewModel : NSObject {
    
    var notificationToken : Notification?
    let bag = DisposeBag()

    // MARK: - Create
    
    func createPursuit(in realm : Realm, pursuit : PursuitModel){
        try? realm.write {
            realm.add(pursuit)
        }
    }
    
    func createChallenge(in realm : Realm, challenge : ChallengeModel){
        try? realm.write {
            realm.add(challenge)
        }
    }
    
    func createQuestion(){
        
    }
    
    func createActionItems(in realm : Realm, actionItems : [ActionItemsModel]){
        try? realm.write {
            realm.add(actionItems)
        }
    }
    
    func createPost(in realm : Realm, post : PostModel){
        try? realm.write {
            realm.add(post)
        }
    }
    
    func createTeam(in realm : Realm, team : [TeamModel]){
        try? realm.write {
            realm.add(team)
        }
    }
    
    func createGoal(in realm : Realm, goal : GoalModel){
        try? realm.write {
            realm.add(goal)
        }
    }
    
    func uploadVideo(){
        
    }
    
    // MARK: - Read
    
    func getRecomendedActionItems(in realm : Realm) -> Observable<Results<ActionItemsModel>> {
        let results = realm.objects(ActionItemsModel.self)
        
        let actionItems = Observable.from(optional: results)
        return actionItems
    }
    
    func getScheduleOptions(){
        
    }
    
    func getCheckInOptions(){
        
    }
    
}
