//
//  SpringboardTabBarController.swift
//  TabBarController
//
//  Created by Arnoymous on 08/14/2018.
//  Copyright (c) 2018 Arnoymous. All rights reserved.
//

import UIKit
import Firebase
import TabBarController
import FirebaseAuth

class SpringboardTabBarController: TabBarController, TabBarControllerDelegate {

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
        let newHomeNavController = UINavigationController(rootViewController: NewHomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        let homeNavController = UINavigationController(rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "create_unselected"), selectedImage: #imageLiteral(resourceName: "create_unselected"))
        let userProfileNavController = UINavigationController(rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        viewControllers = [newHomeNavController, homeNavController, plusNavController, userProfileNavController]
    }
    
    private func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        tabBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
            let photoSelectorController = SelectCameraController()
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController : UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
