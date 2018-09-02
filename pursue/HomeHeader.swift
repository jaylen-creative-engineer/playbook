//
//  HomeHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase

class HomeHeader : UICollectionViewCell {
    
    var accessHomeController : HomeController?
    var interestsLabel = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]
    
    let labelId = "labelId"
    
    let homeLabel : UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var searchBar : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        tf.attributedPlaceholder = NSAttributedString(string: "SEARCH...", attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.gray])
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    lazy var notificationsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "notifications-bell").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var searchButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    lazy var postTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isUserInteractionEnabled = true
        
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePageChange))
        //        tap.numberOfTapsRequired = 1
        //        tableView.addGestureRecognizer(tap)
        return tableView
    }()
    
    let labelCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupView(){
        addSubview(homeLabel)
        addSubview(searchButton)
        addSubview(labelCollectionView)
        
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.register(InterestsLabelCell.self, forCellWithReuseIdentifier: labelId)

        homeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 5, paddingRight: 0, width: homeLabel.intrinsicContentSize.width, height: homeLabel.intrinsicContentSize.height)
        searchButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 19, height: 18)
        searchButton.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor).isActive = true
        labelCollectionView.anchor(top: homeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomeHeader : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelId, for: indexPath) as! InterestsLabelCell
        cell.interestsLabel.text = interestsLabel[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, -14)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 24)
    }
    
}
