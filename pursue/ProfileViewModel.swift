//
//  ProfileViewModel.swift
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

class ProfileViewModel : NSObject {
    
    let bag = DisposeBag()
    var notificationToken : Notification?
    
    // MARK: - Create
    
    func authenticateUser(){
        
    }
    
    func loginUser(in realm : Realm, username : String, password : String){
        let auth_url = URL(string: "https://custom-realm-url")!
        let creds = SyncCredentials.usernamePassword(username: username, password: password, register: false)
        
        SyncUser.logIn(with: creds, server: auth_url) { (user, error) in
          
//            guard let user = user else { fatalError(String(describing: error)) }
        }
    }
    
    func logoutUser(){
        
    }
    
    func forgotPassword(){
        
    }
    
    func createAccount(in realm: Realm, user : UserModel) {
        
        try? realm.write {
            realm.add(user)
        }
    }
    
    // MARK: - Read
    
    func getProfile(in realm: Realm) -> UserModel? {
        let result = realm.object(ofType: UserModel.self, forPrimaryKey: "username")
        return result
    }
    
    func rxUserPursuits(in realm : Realm) -> Observable<Results<PursuitModel>>{
        let result = getProfile(in: realm)?.pursuits.sorted(byKeyPath: "last_updated", ascending: false)
        let pursuits = Observable.from(optional: result)
        return pursuits
    }
    
    func pursuitsCount(in realm : Realm) -> Observable<String> {
        let count = rxUserPursuits(in: realm).map { (pursuits) in
            "\(pursuits.count)"
        }
        return count
    }
    
    func rxUserAdded(in realm : Realm) -> Observable<Results<AddedModel>>{
        let result = getProfile(in: realm)?.added.sorted(byKeyPath: "created_at", ascending: false)
        let added = Observable.from(optional: result)
        return added
    }
    
    func addedCount(in realm : Realm) -> Observable<String> {
        let count = rxUserPursuits(in: realm).map { (added) in
            "\(added.count)"
        }
        return count
    }
    
    func rxUserChallenges(in realm : Realm) -> Observable<Results<ChallengeModel>> {
        let result = getProfile(in: realm)?.challenges.sorted(byKeyPath: "last_updated", ascending: false)
        let challenges = Observable.from(optional: result)
        return challenges
    }
    
    func challengesCount(in realm : Realm) -> Observable<String> {
        let count = rxUserPursuits(in: realm).map { (challenges) in
            "\(challenges.count)"
        }
        return count
    }
    
    func getBlockedStatus(in realm : Realm, blocker : UserModel, blockee : UserModel) -> Observable<BlockUserModel> {
        let result = realm.object(ofType: BlockUserModel.self, forPrimaryKey: "\(String(describing: blocker))\(String(describing: blockee))")
        
        let blockedStatus = Observable.from(optional: result)
        return blockedStatus
    }
    
    // MARK: - Update
    
    func updateAccount(in realm: Realm, user : UserModel){
        try? realm.write {
            realm.add(user, update: true)
        }
    }
    
    func updateProfilePicture() -> String? {
        return "photoUrl"
    }
    
    func changePassword(newPassword : String, confirmPassword : String){
        
    }
    
    // MARK: - Delete
    
    func deleteAccount(in realm : Realm, user : UserModel){
        try? realm.write {
            realm.delete(user)
        }
    }
    
}
