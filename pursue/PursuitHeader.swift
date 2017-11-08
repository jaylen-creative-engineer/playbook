//
//  PursuitHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PursuitHeaderDelegate {
    func handleMessage(for cell : PursuitHeader)
}


class PursuitHeader: HomeHeader {
    
    var pursuitDelegate : PursuitHeaderDelegate?
    
    let switchPursuits : UILabel = {
        let label = UILabel()
        label.text = "DESIGN"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let downArrow : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)
        return button
    }()
    
    lazy var pursueChatIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handleChat(){
        pursuitDelegate?.handleMessage(for: self)
    }
    
    var stackView = UIStackView()
    
    func setupStackView(){
        stackView = UIStackView(arrangedSubviews: [switchPursuits, downArrow])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.anchor(top: pageTitle.bottomAnchor, left: pageTitle.leftAnchor, bottom: nil, right: nil, paddingTop: 38, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: switchPursuits.intrinsicContentSize.width + 16, height: switchPursuits.intrinsicContentSize.height)
    }
    
    override func setupViews() {
        super.setupViews()
        
        pageTitle.text = "Pursuits"
        
        homeChatIcon.isHidden = true
        
        addSubview(pageTitle)
        addSubview(pursueChatIcon)
        
        pageTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
        pursueChatIcon.anchor(top: pageTitle.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 0, height: 20)
        setupStackView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
