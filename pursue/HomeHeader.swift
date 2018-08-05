//
//  HomeHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase

class HomeHeader : UICollectionViewCell {
    
    var accessHomeController : HomeController?
    
    let homeLabel : UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = UIFont(name: "Lato-Black", size: 24)
        return label
    }()
    
    lazy var searchIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(openSearchModal), for: .touchUpInside)
        return button
    }()
    
    @objc func openSearchModal(){
        accessHomeController?.openSearchModal()
        Analytics.logEvent("Change to search screen", parameters: nil)
    }
    
    private func setupView(){
        addSubview(homeLabel)
        addSubview(searchIcon)
        
        homeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 5, paddingRight: 0, width: homeLabel.intrinsicContentSize.width, height: homeLabel.intrinsicContentSize.height)
        searchIcon.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 17.18, height: 18)
        searchIcon.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
