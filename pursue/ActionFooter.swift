//
//  ActionFooter.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ActionFooterDelegate {
    
    func pressedGetStarted(for cell: ActionFooter)
}

class ActionFooter: UICollectionViewCell {
    var delegate : ActionFooterDelegate?
    
    lazy var getStartedButton : UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleChangeToPursuit), for: .touchUpInside)
        return button
    }()
    
    @objc func handleChangeToPursuit(){
        delegate?.pressedGetStarted(for: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(getStartedButton)
        getStartedButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 42, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
