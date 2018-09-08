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
    var interestsLabel = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]
    
    let labelId = "labelId"
    let storyId = "storyId"
    
    let homeLabel : UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var searchBar : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.black])
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = .white
        tf.isUserInteractionEnabled = true
        tf.delegate = self
        tf.motionIdentifier = "searchBar"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSearchTap))
        tap.numberOfTapsRequired = 1
        tf.addGestureRecognizer(tap)
        return tf
    }()
    
    lazy var searchButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.motionIdentifier = "searchButton"
        return button
    }()
    
    let searchBackground : SearchCardView = {
       let view = SearchCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.motionIdentifier = "searchBackground"
        return view
    }()
    
    lazy var notificationsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "notifications-bell-grey").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNotifications), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSearchTap(){
        textFieldDidBeginEditing(searchBar)
        accessHomeController?.goToSearchController()
    }
    
    @objc func handleNotifications(){
        accessHomeController?.goToNotifications()
    }
    
    func setupView(){
        addSubview(homeLabel)
        addSubview(searchBackground)
        addSubview(searchBar)
        addSubview(searchButton)
        addSubview(notificationsButton)


        homeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 5, paddingRight: 0, width: homeLabel.intrinsicContentSize.width, height: homeLabel.intrinsicContentSize.height)
        notificationsButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 18, height: 19)
        notificationsButton.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor).isActive = true
        
        searchBackground.anchor(top: homeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 32)
        searchButton.anchor(top: nil, left: searchBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 14, height: 14)
        searchButton.centerYAnchor.constraint(equalTo: searchBackground.centerYAnchor).isActive = true
        searchBar.anchor(top: nil, left: searchButton.rightAnchor, bottom: nil, right: searchBackground.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 0, height: 20)
        searchBar.centerYAnchor.constraint(equalTo: searchBackground.centerYAnchor).isActive = true
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

extension HomeHeader : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text)
    }
}
