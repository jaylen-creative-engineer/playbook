//
//  ExploreHeaderRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/22/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExploreHeaderDelegate {
    
    func handleMessage(for cell : ExploreHeaderRow)
}

class ExploreHeaderRow: UICollectionViewCell {
    
    var delegate : ExploreHeaderDelegate?
    
    let cellId = "cellId"
    
    let pageTitle : UILabel = {
        let label = UILabel()
        label.text = "Explore"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let titleUnderline : UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var exploreChatIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleMessage), for: .touchUpInside)
        return button
    }()
    
    @objc func handleMessage(){
        delegate?.handleMessage(for: self)
    }
    
    fileprivate func setupPageTitle(){
        addSubview(pageTitle)
        addSubview(exploreChatIcon)

        pageTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        exploreChatIcon.anchor(top: pageTitle.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 0, height: 20)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
