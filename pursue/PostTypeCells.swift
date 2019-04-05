//
//  PostTypeCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/15/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class PostTypeCells : UICollectionViewCell {
    
    let postTypeBackgroundCircle : UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let postTypeLabel : UILabel = {
       let label = UILabel()
        label.text = "Pursuits"
        label.font = UIFont.init(name: "Roboto-Medium", size: 14)
        return label
    }()
    
    let postTypeDescription : UILabel = {
       let label = UILabel()
        label.text = "This is filler text."
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let detailStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fill
        return sv
    }()
    
    func setupView(){
        addSubview(postTypeBackgroundCircle)
        addSubview(detailStackView)
        detailStackView.addArrangedSubview(postTypeLabel)
        detailStackView.addArrangedSubview(postTypeDescription)
        
        postTypeBackgroundCircle.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 48, paddingBottom: 0, paddingRight: 12, width: 20, height: 20)
        postTypeBackgroundCircle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        detailStackView.anchor(top: topAnchor, left: postTypeBackgroundCircle.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
