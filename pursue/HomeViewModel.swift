//
//  HomeViewModel.swift
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

class HomeViewModel : NSObject {
    
    var notificationToken : Notification?
    let bag = DisposeBag()
        
    func getHomeFeedBySelectionType(){
    }
    
    func getPopularPostsBySelectionType(){
        
    }
    
    func viewMoreByType(){
        
    }
    
    func refreshFeed(){
        
    }
        
    func getUserPurusits(in realm : Realm, user : UserModel) -> Observable<Results<PursuitModel>> {
        let predicate = NSPredicate(format: "user == %@", user)
        let results = realm.objects(PursuitModel.self).filter(predicate)
        
        let pursuits = Observable.from(optional: results)
        return pursuits
    }
    
    func getPursuitDetail(in realm : Realm, pursuitId : String) -> Observable<PursuitModel> {
        let result = realm.object(ofType: PursuitModel.self, forPrimaryKey: pursuitId)
        
        let pursuit = Observable.from(optional: result)
        return pursuit
    }
    
    func getPursuitDetailByActionItem(){
        
    }
    
    func getPursuitDetailByQuestion(){
        
    }
    
    func getUserChallenges(in realm : Realm, user : UserModel) -> Observable<Results<ChallengeModel>>{
        let predicate = NSPredicate(format: "user == %@", user)
        let results = realm.objects(ChallengeModel.self).filter(predicate)
        
        let challenges = Observable.from(optional: results)
        return challenges
    }
    
    func getChallengeDetail(in realm : Realm, challengeId : String) -> Observable<ChallengeModel> {
        let result = realm.object(ofType: ChallengeModel.self, forPrimaryKey: challengeId)
        
        let challenge = Observable.from(optional: result)
        return challenge
    }
    
    func getChallengeDetailByPost(in realm : Realm, challengeId : String) -> Observable<ChallengeModel> {
        let result = realm.object(ofType: ChallengeModel.self, forPrimaryKey: challengeId)
        
        let challenge = Observable.from(optional: result)
        return challenge
    }
}
