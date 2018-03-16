//
//  SearchPursuits.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class RecentSearchPursuits : UICollectionViewCell {
    
    var pursuitsDelegate : HomePursuitsRowDelegate?
    var accessHomeController : HomeContainer?

    lazy var pursuitLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.textAlignment = .justified
        return label
    }()
    
    lazy var pursuitImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleHomeTap(){
        
    }
    
    func setupView() {
        addSubview(pursuitImage)
        addSubview(pursuitLabel)
        addSubview(cancelButton)
        
        pursuitImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 140, height: 90)
        pursuitLabel.anchor(top: topAnchor, left: pursuitImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 55)
        cancelButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 15, height: 15)
        cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
