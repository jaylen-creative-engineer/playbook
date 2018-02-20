//
//  PostStepsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/20/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol StepsResizing {
    func cellHeight(height : CGFloat) -> CGFloat
}

class PostStepsCells : UICollectionViewCell, UITextViewDelegate {
    
    var delegate : StepsResizing?
    
    lazy var skillLabel : UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = false
        tv.delegate = self
        tv.text = "Enter bio"
        return tv
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
        textViewDidChange(skillLabel)
        skillLabel.anchor(top: topAnchor, left: selectSkill.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostStepsCells {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width - 32 - 24, height: .infinity)
        
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
                delegate?.cellHeight(height: estimatedSize.height)
            }
        }
    }
}
