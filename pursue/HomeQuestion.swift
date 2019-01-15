//
//  HomeQuestion.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/14/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class HomeQuestion : UICollectionViewCell {
    
    let cellBackgroundView : SmallerCardView = {
        let view = SmallerCardView()
        view.backgroundColor = .white
        return view
    }()
    
    let questionLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.init(name: "Roboto-Black", size: 14)
        label.text = "QUESTIONS"
        return label
    }()
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(questionLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        questionLabel.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: questionLabel.intrinsicContentSize.width, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
