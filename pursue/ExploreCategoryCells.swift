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
        button.backgroundColor = UIColor.black
        button.setTitle("ANIMALS", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        return button
    }()
    
    @objc func handleTouch(){
        delegate?.changeToDetail(for: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(selectInterests)
        selectInterests.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: selectInterests.intrinsicContentSize.width + 30, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
