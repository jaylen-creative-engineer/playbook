//
//  HomeDetailController.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 5/5/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class HomeDetailController : UIViewController {
    
    let headerId = "headerId"
    let cellId = "cellId"
    let actionId = "actionId"
    let goalId = "goalId"
   
    let topView : UIView = {
        let view = UIView()
        return view
    }()
    
    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Keep on running"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    let actionItemsLabel : UILabel = {
        let label = UILabel()
        label.text = "Action Items"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    lazy var pageScrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .white
        sv.isPagingEnabled = true
        sv.isDirectionalLockEnabled = true
        sv.delegate = self
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var usersCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(DetailUserCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    lazy var adjustViewButton : UIButton = {
       let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(adjustView), for: .touchUpInside)
        return button
    }()
    
    let tryButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.cornerRadius = 18
        button.setTitle("Try Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.masksToBounds = true
        return button
    }()
    
    let detailImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let playButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.setTitle("PLAY", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 255, green: 255, blue: 255), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    let otherGoalsLabel : UILabel = {
        let label = UILabel()
        label.text = "Other Goals"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let numberOfGoalsLabel : UILabel = {
        let label = UILabel()
        label.text = "1/8"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let goalLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var goalCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(DetailGoalCell.self, forCellWithReuseIdentifier: goalId)
        return cv
    }()
    
    var pages = [UICollectionView]()
    var topViewsBottomAnchor : NSLayoutConstraint?
    var bottomViewsTopAnchor : NSLayoutYAxisAnchor?
    var topAnchorActiveCheck = true
 
    // MARK: - Setup For Top View
    
    func setupControls(){
        view.addSubview(adjustViewButton)
        view.addSubview(tryButton)
        
        adjustViewButton.anchor(top: nil, left: topView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        adjustViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tryButton.anchor(top: adjustViewButton.topAnchor, left: nil, bottom: nil, right: topView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 38)
    }
    
    func setupUsersCollectionView(){
        topView.addSubview(usersCollectionView)
        topView.addSubview(actionItemsLabel)
        
        usersCollectionView.anchor(top: detailLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
        actionItemsLabel.anchor(top: usersCollectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 18)
    }
    
    func setupTopView(){
        view.addSubview(topView)
        topView.addSubview(detailLabel)
        
        topView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        topViewsBottomAnchor = topView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        topViewsBottomAnchor?.isActive = true
        
        detailLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        detailLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        setupUsersCollectionView()
        setupScrollView()
    }
    
    func setupScrollView(){
        pages = [setupActionItemCollectionView()]
        
        topView.addSubview(pageScrollView)
        pageScrollView.anchor(top: actionItemsLabel.bottomAnchor, left: topView.safeAreaLayoutGuide.leftAnchor, bottom: topView.bottomAnchor, right: topView.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        pages.forEach { (collection) in
            pageScrollView.addSubview(collection)
            collection.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }
    
    func setupActionItemCollectionView() -> UICollectionView {
        let collectionView = DetailActionsCollection(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset = UIEdgeInsets(top: 184, left: 0, bottom: 0, right: 0)
        return collectionView
    }
    
    // MARK: - Setup For Bottom View
 
    func setupGoalsDetail(){
        bottomView.addSubview(goalCollectionView)
        bottomView.addSubview(otherGoalsLabel)
        bottomView.addSubview(goalLineView)
        bottomView.addSubview(numberOfGoalsLabel)
        
        goalCollectionView.anchor(top: nil, left: playButton.rightAnchor, bottom: detailImageView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 42, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 190)
        otherGoalsLabel.anchor(top: nil, left: goalCollectionView.leftAnchor, bottom: goalCollectionView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: otherGoalsLabel.intrinsicContentSize.width, height: 16)
        goalLineView.centerYAnchor.constraint(equalTo: otherGoalsLabel.centerYAnchor).isActive = true
        goalLineView.anchor(top: nil, left: otherGoalsLabel.rightAnchor, bottom: nil, right: detailImageView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 0, height: 1.5)
        numberOfGoalsLabel.anchor(top: nil, left: nil, bottom: goalLineView.topAnchor, right: goalLineView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: numberOfGoalsLabel.intrinsicContentSize.width, height: 16)
    }
    
    func setupBottomView(){
        view.insertSubview(bottomView, belowSubview: topView)
        bottomView.addSubview(detailImageView)
        bottomView.addSubview(playButton)
        
        
        bottomView.anchor(top: topView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        detailImageView.anchor(top: bottomView.topAnchor, left: bottomView.leftAnchor, bottom: bottomView.bottomAnchor, right: bottomView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        playButton.anchor(top: nil, left: detailImageView.leftAnchor, bottom: detailImageView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 18, paddingRight: 0, width: 80, height: 38)
    }
    
    @objc func adjustView(){
//        topViewsBottomAnchor?.isActive = false
        topAnchorActiveCheck = !topAnchorActiveCheck
        topViewsBottomAnchor = topAnchorActiveCheck ? topView.bottomAnchor.constraint(equalTo: view.centerYAnchor) : topView.bottomAnchor.constraint(equalTo: view.topAnchor)
        topViewsBottomAnchor?.isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 12.0)
        pageScrollView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 12.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTopView()
        setupControls()
        setupBottomView()
        setupGoalsDetail()
    }
}

extension HomeDetailController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case usersCollectionView:
            return 5
        default:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case usersCollectionView:
            return CGSize(width: 40, height: 40)
        default:
            return CGSize(width: 150, height: 180)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case usersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailUserCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goalId, for: indexPath) as! DetailGoalCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case usersCollectionView:
            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
}
