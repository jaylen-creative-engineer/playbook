//
//  InterestViewModel.swift
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

class InterestViewModel : NSObject {
    
    var notificationToken : Notification?
    let bag = DisposeBag()
    
    // MARK: - Create
    
    func createInterestList(in realm : Realm, interest : [InterestsModel]){
        try? realm.write {
            realm.add(interest)
        }
    }
    
    // MARK: - Read
    
    func getSelectedInterest(in realm : Realm, user : UserModel) -> Observable<Results<UserInterestsModel>> {
        let predicate = NSPredicate(format: "user == %@", user)
        let result = realm.objects(UserInterestsModel.self).filter(predicate)
        
        let interests = Observable.collection(from: result)
        return interests
    }
    
    func getInterest(in realm : Realm) -> Observable<Results<InterestsModel>> {
        let result = realm.objects(InterestsModel.self).sorted(byKeyPath: "interestName")
        
        let interests = Observable.collection(from: result)
        return interests
    }

    func getGoalsFromInterest(in realm : Realm) -> Observable<Results<GoalModel>> {
        let result = realm.objects(GoalModel.self).sorted(byKeyPath: "goalTitle")
        
        let goals = Observable.collection(from: result)
        return goals
    }
}
