//
//  HomeHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomeHeaderDelegate {
    func handleChat(for cell : HomeHeader)
}
class HomeHeader: ExploreHeaderRow {
    
    var homeDelegate : HomeHeaderDelegate?
    
    lazy var homeChatIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMessage), for: .touchUpInside)
        return button
    }()
    
    
    @objc override func handleMessage(){
        homeDelegate?.handleChat(for: self)
    }
    
    func setupViews(){
        pageTitle.text = "Home"
        exploreChatIcon.isHidden = true
        
        addSubview(homeChatIcon)
        addSubview(pageTitle)
         pageTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
         homeChatIcon.anchor(top: pageTitle.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 0, height: 20)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
