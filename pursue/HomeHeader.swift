//
//  HomeHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomeHeaderDelegate {
    func handleCamera(for cell : HomeHeader)
}
class HomeHeader: ExploreHeaderRow {
    
    var homeDelegate : HomeHeaderDelegate?
    
    let homeCameraIcon : UIButton = {
       let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "camera3").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    func setupViews(){
        backgroundColor = .clear
        
        pageTitle.text = "Home"
        
        addSubview(pageTitle)
         pageTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
