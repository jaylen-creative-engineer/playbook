//
//  SettingsHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/15/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol SettingsHeaderDelegate {
    func goBack()
}

class SettingsHeader : StepsHeader {
    
    var settingsHeaderDelegate : SettingsHeaderDelegate?
    
    func handleBack() {
        settingsHeaderDelegate?.goBack()
    }
    
    func setupPageTitle() {
//        pageTitle.text = "Settings"
//        pageTitle.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
}
