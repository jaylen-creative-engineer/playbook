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
        
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
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
        let searchNavController = UINavigationController(rootViewController: SearchController(collectionViewLayout: UICollectionViewFlowLayout()))
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "create_unselected"), selectedImage: #imageLiteral(resourceName: "create_unselected"))
        let chatNavController = UINavigationController(rootViewController: NotificationsController(collectionViewLayout: UICollectionViewFlowLayout()))
        let userProfileNavController = UINavigationController(rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))

        tabBar.tintColor = UIColor.rgb(red: 74, green: 144, blue: 226)
        tabBar.barTintColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        
        viewControllers = [homeNavController, searchNavController, plusNavController, chatNavController, userProfileNavController]
        
        guard let items = tabBar.items else { return }
        let tabHome = items[0]
        tabHome.image = #imageLiteral(resourceName: "home_unselected").withRenderingMode(.alwaysOriginal)
        tabHome.selectedImage = #imageLiteral(resourceName: "home_selected").withRenderingMode(.alwaysOriginal)
        tabHome.title = "Home"
        tabHome.titlePositionAdjustment = UIOffsetMake(0, 2)
        
        let tabSearch = items[1]
        tabSearch.image = #imageLiteral(resourceName: "search_unselected").withRenderingMode(.alwaysOriginal)
        tabSearch.selectedImage = #imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal)
        tabSearch.title = "Search"
        tabSearch.titlePositionAdjustment = UIOffsetMake(0, 2)
        
        let tabCreate = items[2]
        tabCreate.image = #imageLiteral(resourceName: "custom-create-button").withRenderingMode(.alwaysOriginal)
        tabCreate.selectedImage = #imageLiteral(resourceName: "custom-create-button").withRenderingMode(.alwaysOriginal)
        tabCreate.title = "Create"
        tabCreate.titlePositionAdjustment = UIOffsetMake(0, 2)

        let tabChat = items[3]
        tabChat.image = #imageLiteral(resourceName: "chat_unselected").withRenderingMode(.alwaysOriginal)
        tabChat.selectedImage = #imageLiteral(resourceName: "chat-selected").withRenderingMode(.alwaysOriginal)
        tabChat.title = "Chat"
        tabChat.titlePositionAdjustment = UIOffsetMake(0, 2)
        
        let tabProfile = items[4]
        tabProfile.image = #imageLiteral(resourceName: "profile_unselected").withRenderingMode(.alwaysOriginal)
        tabProfile.selectedImage = #imageLiteral(resourceName: "profile-selected").withRenderingMode(.alwaysOriginal)
        tabProfile.title = "Profile"
        tabProfile.titlePositionAdjustment = UIOffsetMake(0, 2)
//
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(2, 0, -4, 0)
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
