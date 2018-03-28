//
//  CreateInterestsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol InterestNameSelected {
    func interestSelected(for cell : CreateInterestsCells)
}

class CreateInterestsCells : UICollectionViewCell {
    
    var interest : CreateInterests? {
        didSet {
            interestButton.setTitle(interest?.interest_name, for: .normal)
        }
    }
    
    var delegate : InterestNameSelected?
    
    lazy var interestButton : UIButton = {
       let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(handleCellSelected), for: .touchUpInside)
        return button
    }()
    
    var isClicked = false
    @objc func handleCellSelected(){
        delegate?.interestSelected(for: self)
        isClicked = !isClicked
        
        if isClicked == true {
            interestButton.backgroundColor = .black
            interestButton.setTitleColor(.white, for: .normal)
        } else {
            interestButton.backgroundColor = .white
            interestButton.setTitleColor(.black, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(interestButton)
        interestButton.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        interestButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
