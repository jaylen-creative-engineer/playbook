//
//  ActionExplanation.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ActionExplanation: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    let actionView : UIView = {
        let view = UIView()
        return view
    }()
    
    
    let actionLabel : UILabel = {
        let label = UILabel()
        label.text = "Interest In Action"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25))
        label.textColor = .black
        return label
    }()
    
    let actionDetailLabel : UILabel = {
        let label = UILabel()
        label.text = "Make progress on the hobbies & pursuits you are passionate about."
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    let actionImage : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "tumblr_nbicgmPoWW1r46py4o1_1280")
        return iv
    }()
    
    let cardView : SmallerCardView = {
       let card = SmallerCardView()
        return card
    }()
    fileprivate func setupView(){
        addSubview(actionView)
        addSubview(cardView)
        cardView.addSubview(actionImage)
        actionView.addSubview(actionLabel)
        actionView.addSubview(actionDetailLabel)
        
        cardView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 50, height:50)
        actionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        actionImage.anchor(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: cardView.bottomAnchor, right: cardView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:0)
        actionLabel.anchor(top: topAnchor, left: actionImage.rightAnchor, bottom: nil, right: actionView.rightAnchor, paddingTop: 15, paddingLeft: 14, paddingBottom: 0, paddingRight: 16, width: 0, height: 20)
        actionDetailLabel.anchor(top: actionLabel.bottomAnchor, left: actionLabel.leftAnchor, bottom: nil, right: actionLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
