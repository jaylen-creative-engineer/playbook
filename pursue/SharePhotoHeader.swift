//
//  SharePhotoHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/7/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SharePhotoHeader : UICollectionViewCell {
    
    let backgroundFill : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var checkButton : UIButton = {
        let button = UIButton()
        button.setTitle("Share Post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopBar()
    }
    
    private func setupTopBar(){
        let guide = safeAreaLayoutGuide
        
        addSubview(backgroundFill)
        addSubview(cancelButton)
        addSubview(checkButton)
        
        backgroundFill.backgroundColor = .black
        backgroundFill.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        cancelButton.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 18, height: 18)
        checkButton.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 12, width: 18, height: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
