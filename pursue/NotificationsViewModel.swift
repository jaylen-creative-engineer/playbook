//
//  NotificationsViewModel.swift
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

class NotificationsViewModel : NSObject {
    
    var notificationToken : Notification?
    let bag = DisposeBag()

    func getUserNotifications(in realm : Realm, user : UserModel) -> Observable<Results<NotificationsModel>> {
        let predicate = NSPredicate(format: "user == %@", user)
        let results = realm.objects(NotificationsModel.self).filter(predicate).sorted(byKeyPath: "created_at")
        
        let notifications = Observable.from(optional: results)
        return notifications
    }
}
