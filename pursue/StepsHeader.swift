//
//  StepsHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/8/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol StepsDelegate {
    func handleMessage(for cell : StepsHeader)
    func goBack()
}

class StepsHeader : PursuitsDetailHeader {
    
    var stepsDelegate : StepsDelegate?
    
    lazy var stepBackButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    
    override func dismissView() {
        stepsDelegate?.goBack()
    }
    
    override func handleChat() {
        stepsDelegate?.handleMessage(for: self)
    }
    
    override func setupTopNavBar() {
        super.setupTopNavBar()
        backButton.isHidden = true
        
        addSubview(stepBackButton)
        stepBackButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)

    }
}
