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
    
    @objc func handleHomeTap(){
        accessHomeController?.handleHomeTap()
    }
    
    @objc func handleChatTap(){
        accessHomeController?.handleChatPageChange()
    }
    
    @objc func handleCreateTap(){
        accessHomeController?.handleCameraTap()
    }
    
    func setupBackground(){
        addSubview(rectangleView)
        addSubview(createButton)
        addSubview(homeButton)
        addSubview(chatButton)
        
        rectangleView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        createButton.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor).isActive = true
        createButton.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor).isActive = true
        createButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 28, height: 28)
        homeButton.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor).isActive = true
        homeButton.anchor(top: nil, left: nil, bottom: nil, right: createButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 48, width: 18, height: 18)
        chatButton.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor).isActive = true
        chatButton.anchor(top: nil, left: createButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 21, height: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
