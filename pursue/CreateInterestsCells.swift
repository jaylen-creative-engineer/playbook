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
    
    let checkBox : UIButton = {
       let button = UIButton(type: .system)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    let interestsLabel : UILabel = {
       let label = UILabel()
        label.text = "Animals"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    lazy var interestButton : UIButton = {
       let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.init(white: 0.6, alpha: 0.3)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(handleCellSelected), for: .touchUpInside)
        return button
    }()
    
    var isClicked = false
    var accessDetailView : CaptureDetailView?
    
    @objc func handleCellSelected(){
        delegate?.interestSelected(for: self)
        isClicked = !isClicked
        
        if isClicked == true {
            accessDetailView?.createInterestId = (interest?.interestId)!
            interestButton.backgroundColor = .blue
            interestButton.setTitleColor(.white, for: .normal)
            
        } else {
            interestButton.backgroundColor = UIColor.init(white: 0.6, alpha: 0.3)
            interestButton.setTitleColor(.black, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(checkBox)
        addSubview(interestsLabel)
        checkBox.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 18, height: 18)
        interestsLabel.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor).isActive = true
        interestsLabel.anchor(top: nil, left: checkBox.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 18, width: 0, height: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
