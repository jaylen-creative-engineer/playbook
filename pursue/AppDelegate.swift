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
import GoogleSignIn
import Alamofire
import FBSDKCoreKit
import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var userPhoto : Data?
    var accessSignupController : SignupController?
    let profileService = ProfileServices()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Mixpanel.initialize(token: "966109a7aee1fb1067d5c2363b8a4284")
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
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
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to login \(error)")
            return
        }
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        Auth.auth().signInAndRetrieveData(with: credentials) { (user, error) in
            if let error = error {
                print("Failed to create account: ", error)
                return
            }
            
            guard let email = user?.user.email else { return }
            guard let fullname = user?.user.displayName else { return }
            
            if let profileImageUrl = user?.user.photoURL {
                do {
                    let imageData = try Data(contentsOf: profileImageUrl as URL)
                    self.userPhoto = imageData
                } catch {
                    print("Unable to load data: \(error)")
                }
            }
            
            guard let googleProfilePic = self.userPhoto else { return }
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profile-images").child(filename).putData(googleProfilePic, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload", err)
                }
                
                guard let photoUrl = user?.user.photoURL?.absoluteString else { return }
                self.profileService.socialLogin(email: email, fullname: fullname, photoUrl: photoUrl, completion: { (_) in
                    let layout = UICollectionViewFlowLayout()
                    let interestsController = InterestsController(collectionViewLayout: layout)
                    interestsController.viewType = "signupInterest"
                    self.window?.rootViewController = interestsController
                })
                
            })
            
        }
    }
    
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        return handled
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
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
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

