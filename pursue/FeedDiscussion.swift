//
//  FeedDiscussion.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/14/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedDiscussion : UICollectionViewCell {
    
    lazy var discussionBackground : TopRectangleView = {
        let view = TopRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let discussionLabel : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "I need some help getting started with marketing my profile on Instagram.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
        
    }()
    
    let discussionSubLabel : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "I need some help getting started with marketing my profile on Instagram.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.attributedText = attrString
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView(){
        addSubview(discussionBackground)
        addSubview(discussionLabel)
        addSubview(discussionSubLabel)
        
        discussionBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 95)
        discussionLabel.anchor(top: discussionBackground.topAnchor, left: discussionBackground.leftAnchor, bottom: nil, right: discussionBackground.rightAnchor, paddingTop: 2, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
        discussionSubLabel.anchor(top: discussionLabel.bottomAnchor, left: discussionLabel.leftAnchor, bottom: nil, right: discussionBackground.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 45)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
