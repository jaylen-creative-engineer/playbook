//
//  SearchCarouselCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Gemini

class SearchCarouselCell : GeminiCell {
    
    
    lazy var photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let photoBackground : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.textColor = .white
        label.font = UIFont(name: "Lato-Black", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    @objc func handleHeld(){
    }
    
    func setupView(){
        addSubview(photoBackground)
        addSubview(photo)
        addSubview(detailLabel)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photo.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        detailLabel.anchor(top: nil, left: photo.leftAnchor, bottom: photo.bottomAnchor, right: photo.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 24, paddingRight: 4, width: 0, height: 20)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHeld))
        addGestureRecognizer(longGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
