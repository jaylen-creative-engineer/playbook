//
//  MainTabController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase

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
        let searchNavController = UINavigationController(rootViewController: ExploreController(collectionViewLayout: UICollectionViewFlowLayout()))
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "create_unselected"), selectedImage: #imageLiteral(resourceName: "create_unselected"))
        let userProfileNavController = UINavigationController(rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        tabBar.tintColor = .black
        tabBar.barTintColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        
        viewControllers = [homeNavController,searchNavController, plusNavController, userProfileNavController]
        
        guard let items = tabBar.items else { return }
        let tabHome = items[0]
        tabHome.image = #imageLiteral(resourceName: "home_unselected").withRenderingMode(.alwaysOriginal)
        tabHome.selectedImage = #imageLiteral(resourceName: "home_selected").withRenderingMode(.alwaysOriginal)
        
        let tabSearch = items[1]
        tabSearch.image = #imageLiteral(resourceName: "search_unselected").withRenderingMode(.alwaysOriginal)
        tabSearch.selectedImage = #imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal)
        
        let tabCreate = items[2]
        tabCreate.image = #imageLiteral(resourceName: "create_unselected").withRenderingMode(.alwaysOriginal)
        tabCreate.selectedImage = #imageLiteral(resourceName: "create_unselected").withRenderingMode(.alwaysOriginal)
        
        let tabProfile = items[3]
        tabProfile.image = #imageLiteral(resourceName: "profile_unselected").withRenderingMode(.alwaysOriginal)
        tabProfile.selectedImage = #imageLiteral(resourceName: "profile-selected").withRenderingMode(.alwaysOriginal)
        
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(4, 4, -4, -4)
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
