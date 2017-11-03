//
//  ExploreCategoryCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryDetailDelegate {
    func changeToDetail(for cell : ExploreCategoryCells)
}

class ExploreCategoryCells : UICollectionViewCell {
    
    var delegate : CategoryDetailDelegate?
    
    lazy var selectInterests : UIButton = {
       let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(handleCategoryDetail), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonLabel : UILabel = {
       let label = UILabel()
        label.text = "ANIMALS"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCategoryDetail))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func handleCategoryDetail(){
        delegate?.changeToDetail(for : self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(selectInterests)
        selectInterests.addSubview(buttonLabel)
        
        selectInterests.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: buttonLabel.intrinsicContentSize.width + 30, height: 0)
        selectInterests.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonLabel.centerYAnchor.constraint(equalTo: selectInterests.centerYAnchor).isActive = true
        buttonLabel.centerXAnchor.constraint(equalTo: selectInterests.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
