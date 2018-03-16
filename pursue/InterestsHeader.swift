//
//  InterestsHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class InterestsHeader : UICollectionViewCell {
    let chooseLabel : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 26)
        label.textAlignment = .justified
        
        let attrString = NSMutableAttributedString(string: "Choose three or more categories that represent what you want to see.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let guide = safeAreaLayoutGuide
        addSubview(chooseLabel)
        chooseLabel.anchor(top: guide.topAnchor, left: leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 64, width: 0, height: 140)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

