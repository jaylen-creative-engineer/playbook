//
//  Utility.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/4/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class Utility {
    
    class func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}
