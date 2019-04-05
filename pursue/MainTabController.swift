//
//  MainTabController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainTabController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - View Controllers
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 1 {
            
            let photoSelectorController = SelectCameraController()
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            }
            return
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        let homeNavController = UINavigationController(rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "create_unselected"), selectedImage: #imageLiteral(resourceName: "create_unselected"))
        let notificationController = UINavigationController(rootViewController: UIViewController())
        let userProfileNavController = UINavigationController(rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        tabBar.tintColor = UIColor.black
        tabBar.barTintColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        
        viewControllers = [homeNavController, plusNavController, notificationController, userProfileNavController]
        
        guard let items = tabBar.items else { return }
        let tabHome = items[0]
        tabHome.image = UIImage(named: "home_unselected")?.withRenderingMode(.alwaysOriginal)
        tabHome.selectedImage = UIImage(named: "home_selected")?.withRenderingMode(.alwaysOriginal)
        
        let tabCreate = items[1]
        tabCreate.image = UIImage(named: "create_unselected")?.withRenderingMode(.alwaysOriginal)
        tabCreate.selectedImage = UIImage(named: "create_unselected")?.withRenderingMode(.alwaysOriginal)
        
        let tabNotification = items[2]
        tabNotification.image = UIImage(named : "notification-outline")?.withRenderingMode(.alwaysOriginal)
        tabNotification.selectedImage = UIImage(named : "notification")?.withRenderingMode(.alwaysOriginal)
        
        let tabProfile = items[3]
        tabProfile.image = UIImage(named: "profile_unselected")?.withRenderingMode(.alwaysOriginal)
        tabProfile.selectedImage = UIImage(named: "profile_selected")?.withRenderingMode(.alwaysOriginal)
        
        for item in items {
            item.imageInsets = UIEdgeInsets.init(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController : UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
