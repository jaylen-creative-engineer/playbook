//
//  HomeMenuBar.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeMenuBar : UIView {

    var accessHomeController : HomeController?

    let rectangleView : TabView = {
       let view = TabView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var createButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "custom-create-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCreateTap), for: .touchUpInside)
        return button
    }()
    
    lazy var homeButton : UIButton = {
       let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleHomeTap), for: .touchUpInside)
        return button
    }()
    
    lazy var chatButton : UIButton = {
       let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleChatTap), for: .touchUpInside)
        return button
    }()
    
    lazy var userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()

    @objc func handleHomeTap(){
    }
    
    @objc func handleChatTap(){
    }
    
    @objc func handleCreateTap(){
    }
    
    @objc func handleProfileTap(){
    }
    
    func setupBackground(){
        addSubview(rectangleView)
        addSubview(createButton)
        addSubview(homeButton)
        addSubview(chatButton)
        addSubview(userPhoto)
        
        rectangleView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        homeButton.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor).isActive = true
        homeButton.anchor(top: nil, left: rectangleView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 280 / 8, paddingBottom: 0, paddingRight: 0, width: 18, height: 18)
        createButton.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor).isActive = true
        createButton.anchor(top: nil, left: homeButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: (280 / 8) + 2, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        chatButton.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor).isActive = true
        chatButton.anchor(top: nil, left: nil, bottom: nil, right: userPhoto.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: (280 / 8) + 2, width: 24, height: 21)
        userPhoto.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor).isActive = true
        userPhoto.anchor(top: nil, left: nil, bottom: nil, right: rectangleView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 280 / 8, width: 24, height: 24)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
