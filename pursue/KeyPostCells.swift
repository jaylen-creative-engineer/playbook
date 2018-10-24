//
//  KeyPostCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol KeyPostCellsDelegate {
    func handleSave(for cell : KeyPostCells)
}

class KeyPostCells : UICollectionViewCell {
    
    var delegate : KeyPostCellsDelegate?
    
    let countLabel : UILabel = {
       let label = UILabel()
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "beauty").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDetail : UILabel = {
       let label = UILabel()
        label.text = "Some text about this post"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let timeLabel : UILabel = {
       let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var saveBackground : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    lazy var createButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSave(){
        delegate?.handleSave(for: self)
    }
    
    func setupView(){
        addSubview(countLabel)
        addSubview(imageView)
        addSubview(postDetail)
        addSubview(timeLabel)
        addSubview(createButton)
        addSubview(saveBackground)
        
        countLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 18)
        imageView.anchor(top: countLabel.topAnchor, left: countLabel.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 72, height: 0)
        createButton.anchor(top: countLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 19, height: 19)
        saveBackground.centerYAnchor.constraint(equalTo: createButton.centerYAnchor).isActive = true
        saveBackground.centerXAnchor.constraint(equalTo: createButton.centerXAnchor).isActive = true
        saveBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        postDetail.anchor(top: imageView.topAnchor, left: imageView.rightAnchor, bottom: nil, right: createButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        timeLabel.anchor(top: postDetail.bottomAnchor, left: postDetail.leftAnchor, bottom: nil, right: createButton.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        timeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
