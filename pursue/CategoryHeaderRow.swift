//
//  CategoryHeaderRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryHeaderDelegate {
    func goBack()
    func handleMessage(for cell : CategoryHeaderRow)
}
class CategoryHeaderRow : UICollectionViewCell {
    
    let cellId = "cellId"
    var categoryDelegate : CategoryHeaderDelegate?
    
    let pageTitle : UILabel = {
        let label = UILabel()
        label.text = "Animals"
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        button.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
        return button
    }()
    
    lazy var categoryBackIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "back-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    @objc func handleBack(){
        categoryDelegate?.goBack()
    }
    
    @objc func handleChat(){
        categoryDelegate?.handleMessage(for: self)
    }
    
    func setupPageTitle(){
        addSubview(categoryBackIcon)
        addSubview(pageTitle)
        addSubview(exploreChatIcon)

        categoryBackIcon.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        pageTitle.anchor(top: topAnchor, left: categoryBackIcon.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
        exploreChatIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 0, height: 20)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageTitle()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

