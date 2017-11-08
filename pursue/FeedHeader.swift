//
//  FeedHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol FeedDelegate {
    func goBack()
    func handleMessage(for cell : FeedHeader)
}

class FeedHeader : CategoryHeaderRow {
    var feedDelegate : FeedDelegate?
    
    override func handleChat() {
        feedDelegate?.handleMessage(for: self)
    }
    
    override func handleBack() {
        feedDelegate?.goBack()
    }
    
    override func setupPageTitle() {
        super.setupPageTitle()
        pageTitle.text = "Feed"
    }
}
