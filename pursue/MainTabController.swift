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
        
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home-unselected"), selectedImage: #imageLiteral(resourceName: "home-selected"),rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: ExploreController(collectionViewLayout: UICollectionViewFlowLayout()))
        let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile-unselected"), selectedImage: #imageLiteral(resourceName: "profile-selected"), rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        
        viewControllers = [homeNavController,searchNavController, plusNavController, userProfileNavController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(4, 8, -4, -8)
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
