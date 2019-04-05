//
//  EngagementViewModel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 3/23/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit
import RxSwift
import RxRealm
import RxCocoa
import RealmSwift

class EngagementViewModel : NSObject {
    
    var notificationToken : Notification?
    let bag = DisposeBag()
    
    // MARK: - Get
    
    func getRecentSaves(in realm : Realm, user : UserModel) -> Observable<Results<PostEngagementsModel>> {
        let predicate = NSPredicate(format: "user == %@", user)
        let results = realm.objects(PostEngagementsModel.self).filter(predicate).sorted(byKeyPath: "created_at")
        
        let saves = Observable.from(optional: results)
        return saves
    }
        
    // MARK: - Toggle
    
    func toggleInterest(interest : InterestsModel, in realm : Realm){
        let userInterestModel = UserInterestsModel()
        userInterestModel.toggleSelected()
    }
    
    func toggleSave(){
        let postEngagementModel = PostEngagementsModel()
        postEngagementModel.toggleSave()
    }
    
    func toggleTry(){
        let pursuitEngagementModel = PursuitEngagementsModel()
        pursuitEngagementModel.toggleTry()
    }
    
    func toggleActionItem(){
        
    }
    
    func toggleAddUser(){
        let userAddedModel = AddedModel()
        userAddedModel.toggleAdded()
    }
    
    func toggleJoinChallenge(){
        
    }
    
    func toogleBlockUser(){
        let blockUserModel = BlockUserModel()
        blockUserModel.toggleBlock()
    }
}
