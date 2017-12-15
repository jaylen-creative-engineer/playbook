//
//  ChallengesHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/7/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ChallengeDelegate {
    func goBack()
    func handleMessage(for cell : ChallengesHeader)
}
class ChallengesHeader : PostDetailHeader {
    
    var challengeDelegate : ChallengeDelegate?
    
    lazy var challengeBackButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    lazy var challengeChatIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
        return button
    }()
    
    @objc func dismissView(){
        challengeDelegate?.goBack()
    }
    
    @objc func handleChat() {
        challengeDelegate?.handleMessage(for: self)
    }
    
     func setupTopNavBar() {
        addSubview(challengeBackButton)
        addSubview(challengeChatIcon)
        
        challengeBackButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        challengeChatIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 0, height: 20)
    }
}
