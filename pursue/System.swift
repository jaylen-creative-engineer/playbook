//
//  System.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/26/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
    
    static func clearTabBar(forBar tabBar : UITabBar) {
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
    }
}
