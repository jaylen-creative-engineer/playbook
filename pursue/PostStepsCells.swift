//
//  PostStepsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/20/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostStepsCells : UICollectionViewCell {
    
    lazy var skillLabel : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Work Hard Right Now", attributes:attributes)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSteps))
        tap.numberOfTapsRequired = 1
        tf.addGestureRecognizer(tap)
        tf.isUserInteractionEnabled = true
        return tf
    }()
    
    let selectSkill : UIButton = {
        let iv = UIButton()
        iv.layer.borderWidth = 1
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.gray.cgColor
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(toggleSteps), for: .touchUpInside)
        return iv
    }()
    
    let deleteIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "delete-icon").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var isActive = false
    @objc func toggleSteps(){
       
        addSubview(deleteIcon)
        deleteIcon.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 25, height: 25)
        deleteIcon.centerYAnchor.constraint(equalTo: selectSkill.centerYAnchor).isActive = true
        
            isActive = !isActive
            if isActive == true {
                deleteIcon.isHidden = false
            } else {
                deleteIcon.isHidden = true
            }
    }
    
    func setupView(){
        addSubview(selectSkill)
        addSubview(skillLabel)
        
        selectSkill.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 16, height: 2)
        
        skillLabel.anchor(top: nil, left: selectSkill.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 12, width: 0, height: skillLabel.intrinsicContentSize.height)
        skillLabel.centerYAnchor.constraint(equalTo: selectSkill.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
