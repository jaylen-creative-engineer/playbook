//
//  ViewWithDiagonalLine.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ViewWithDiagonalLine : UIView {
    
    private let line : UIView
    private var lengthContraint : NSLayoutConstraint!
    
    override init(frame: CGRect) {
        line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .white
        super.init(frame: .zero)
        clipsToBounds = true
        addSubview(line)
        
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        lengthContraint = NSLayoutConstraint(item: line, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        addConstraint(lengthContraint)
        addConstraint(NSLayoutConstraint(item: line, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: line, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lengthContraint.constant = sqrt(pow(frame.size.width, 2) + pow(frame.size.height, 2))
        line.transform = CGAffineTransform(rotationAngle: atan2(frame.size.height, frame.size.width))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
