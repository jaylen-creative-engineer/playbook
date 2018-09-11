//
//  HomeHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase
import Motion

class HomeHeader : UICollectionViewCell {
    
    var accessHomeController : HomeController?
    
    let homeLabel : UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var searchIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.motionIdentifier = "searchIcon"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSearchTap))
        tap.numberOfTapsRequired = 1
        button.addGestureRecognizer(tap)
        return button
    }()
    
    @objc func handleSearchTap(){
        accessHomeController?.goToSearchController()
    }
    
    func setupView(){
        addSubview(homeLabel)
        addSubview(searchIcon)


        homeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: homeLabel.intrinsicContentSize.width, height: homeLabel.intrinsicContentSize.height)
        searchIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 18, height: 18)
        searchIcon.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isMotionEnabled = true
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
