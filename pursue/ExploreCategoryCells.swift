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
        button.backgroundColor = UIColor.white
        button.setTitle("ANIMALS", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        return button
    }()
    
    @objc func handleTouch(){
        delegate?.changeToDetail(for: self)
    }

    func setupView(){
        addSubview(selectInterests)
        selectInterests.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
