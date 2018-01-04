//
//  MenuCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CustomNavigationDelegate {
    func changeToExplore()
    func changeToHome()
    func changeToProfile()
}

class MenuCell : UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var delegate : CustomNavigationDelegate?
    
    lazy var homeIcon : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "Pursuit").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(homeActive), for: .touchUpInside)
        return button
    }()
    
    lazy var exploreIcon : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "explore_icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(exploreActive), for: .touchUpInside)
        return button
    }()
    
    lazy var profileIcon : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(profileActive), for: .touchUpInside)
        return button
    }()
        
    func setupView(){
        addSubview(exploreIcon)
        addSubview(homeIcon)
        addSubview(profileIcon)
        exploreIcon.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        homeIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 65, height: 34)
        homeIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 30.5, height: 30.5)
        homeActive()
    }
    
    @objc func exploreActive(){
        delegate?.changeToExplore()
        exploreIcon.tintColor = UIColor.black
        homeIcon.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    @objc func homeActive(){
        delegate?.changeToHome()
        homeIcon.tintColor = UIColor.black
        exploreIcon.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
    }

    
    @objc func profileActive(){
        delegate?.changeToProfile()
        homeIcon.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        exploreIcon.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
