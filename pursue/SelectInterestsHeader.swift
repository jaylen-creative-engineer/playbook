//
//  SelectInterestsHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/3/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol SelectToProfile {
    func switchToProfile()
}

class SelectInterestsHeader : StepsHeader {
    
    var delegate : SelectToProfile?
    
    let nextLabel : UILabel = {
        let label = UILabel()
        label.text = "Next"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.backgroundColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(pageChange))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func pageChange(){
        delegate?.switchToProfile()
    }
    
    func setupPageTitle() {
//        pageTitle.text = "Select Interests"
        addSubview(nextLabel)
        nextLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: nextLabel.intrinsicContentSize.width, height: 18)
    }
}
