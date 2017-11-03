//
//  PursuitHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PursuitHeaderDelegate {
    func handleCamera(for cell : PursuitHeader)
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
    
    var stackView = UIStackView()
    
    func setupStackView(){
        stackView = UIStackView(arrangedSubviews: [switchPursuits, downArrow])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.anchor(top: pageTitle.bottomAnchor, left: pageTitle.leftAnchor, bottom: nil, right: nil, paddingTop: 38, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: switchPursuits.intrinsicContentSize.width + 16, height: switchPursuits.intrinsicContentSize.height)
    }
    
    override func handleMessage() {
        pursuitDelegate?.handleMessage(for: self)
    }
    
    override func setupViews() {
        super.setupViews()
        
        pageTitle.text = "Pursuits"
        
        addSubview(pageTitle)
        
        pageTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
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
