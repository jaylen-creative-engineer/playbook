//
//  ActionHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
protocol ActionHeaderDelegate {
    func handleMessage(for cell : ActionHeader)
}


class ActionHeader: HomeHeader {
    
    var actionDelegate : ActionHeaderDelegate?
    
    
    override func handleMessage(){
        actionDelegate?.handleMessage(for: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        pageTitle.text = "Pursue"
        homeCameraIcon.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
