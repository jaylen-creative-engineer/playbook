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
    
    lazy var selectInterests : UILabel = {
       let label = UILabel()
        label.text = "ANIMALS"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTouch))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func handleTouch(){
        delegate?.changeToDetail(for: self)
    }

    func setupView(){
        addSubview(selectInterests)
        
        selectInterests.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 29)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
