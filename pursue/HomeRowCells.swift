//
//  HomeRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomeImageEngagements {
    func homeTapped()
    func homeHeld()
}

class HomeRowCells : UICollectionViewCell {
    
    var delegate : HomeImageEngagements?
    
    lazy var postImage : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    let homeMainDescription : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 2
        label.textColor = .black
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        label.addGestureRecognizer(longGesture)
        return label
    }()
    
    let cardView : HomeView = {
        let card = HomeView()
        card.backgroundColor = .clear
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    @objc func handleHomeTap(){
        delegate?.homeTapped()
    }
    
    @objc func handleHomeHold(){
        delegate?.homeHeld()
    }
    
    func setupView() {
        addSubview(homeMainDescription)
        addSubview(postImage)
        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 52, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 280)
        homeMainDescription.anchor(top: postImage.bottomAnchor, left: postImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: homeMainDescription.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
