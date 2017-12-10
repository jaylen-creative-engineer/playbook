//
//  CameraCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/1/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CustomCameraNavigationDelegate {
    func changeToLibrary()
    func changeToPhoto()
}

class CameraCell : UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var delegate : CustomCameraNavigationDelegate?
    
    lazy var photoIcon : UIButton = {
        let button = UIButton()
        button.setTitle("PHOTO", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(photoActive), for: .touchUpInside)
        return button
    }()
    
    lazy var libraryIcon : UIButton = {
        let button = UIButton()
        button.setTitle("LIBRARY", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(libraryActive), for: .touchUpInside)
        return button
    }()
    
    @objc func photoActive(){
        delegate?.changeToPhoto()
        libraryIcon.setTitleColor(UIColor.gray, for: .normal)
        photoIcon.setTitleColor(UIColor.black, for: .normal)
    }
    
    @objc func libraryActive(){
        delegate?.changeToLibrary()
        
        libraryIcon.setTitleColor(UIColor.black, for: .normal)
        photoIcon.setTitleColor(UIColor.gray, for: .normal)
    }
    
    func setupView(){
        let stackView = UIStackView(arrangedSubviews: [libraryIcon, photoIcon])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
     
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photoActive()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
