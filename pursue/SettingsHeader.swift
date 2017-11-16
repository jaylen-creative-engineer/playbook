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

class SettingsHeader : FeedHeader {
    
    var settingsHeaderDelegate : SettingsHeaderDelegate?
    
    override func handleBack() {
        super.handleBack()
        settingsHeaderDelegate?.goBack()
    }
    
    override func setupPageTitle() {
        super.setupPageTitle()
        pageTitle.text = "Settings"
        exploreChatIcon.isHidden = true
    }
    
}
