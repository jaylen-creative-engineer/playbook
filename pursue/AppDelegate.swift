//
//  AppDelegate.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import Alamofire
import Mixpanel
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var userPhoto : Data?
    var accessSignupController : SignupController?
    let profileService = ProfileServices()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        setCategories()

        Mixpanel.initialize(token: "d691451088376e5aaa53c095d5ca4e44")
        Mixpanel.mainInstance().loggingEnabled = true
        Mixpanel.mainInstance().flushInterval = 5
        let allTweaks: [TweakClusterType] = [MixpanelTweaks.floatTweak,
                                             MixpanelTweaks.intTweak,
                                             MixpanelTweaks.boolTweak,
                                             MixpanelTweaks.stringTweak]
        MixpanelTweaks.setTweaks(tweaks: allTweaks)
        
        FirebaseApp.configure()
        
        if UserDefaults.standard.value(forKey: "firstAppLaunch") == nil {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            window = UIWindow()
            window?.rootViewController = SwipingController(collectionViewLayout: layout)
            window?.makeKeyAndVisible()
        } else {
            window = UIWindow()
            window?.rootViewController = MainTabController()
            window?.makeKeyAndVisible()
            UILabel.appearance().font = UIFont(name: "Montserrat", size: 24)
        }
        
        return true
    }
    
    
    func setCategories(){
        let clearRepeatAction = UNNotificationAction(
            identifier: "clear.repeat.action",
            title: "Stop Repeat",
            options: [])
        
        let pursuitCategory = UNNotificationCategory(
            identifier: "pizza.reminder.category",
            actions: [clearRepeatAction],
            intentIdentifiers: [],
            options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([pursuitCategory])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Did recieve response: \(response.actionIdentifier)")
        if response.actionIdentifier == "clear.repeat.action"{
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [response.notification.request.identifier])
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound, .badge])
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension MixpanelTweaks {
    public static let floatTweak = Tweak<CGFloat>(tweakName: "floatTweak", defaultValue: 20.5, min: 0, max: 30.1)
    public static let intTweak = Tweak<Int>(tweakName: "intTweak", defaultValue: 10, min: 0)
    public static let boolTweak = Tweak(tweakName: "boolTweak", defaultValue: true)
    public static let stringTweak = Tweak(tweakName: "stringTweak", defaultValue: "hello")
}
