//
//  HomePursuitsLists.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomePursuitsLists : UICollectionViewCell {
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.text = "Pursuits You May Like."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let showMoreButton : UIButton = {
       let button = UIButton()
        button.setTitle("SHOW 5+ MORE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.init(25))
        return button
    }()
    
    let cellId = "cellId"
    var accessHomeController : HomeController?
    
    let pursuitImage = ["tumblr_nd45sgtlLa1r46py4o1_1280", "tumblr_mggs0iBUBz1r46py4o1_1280", "tumblr_mly4nqx7dF1r46py4o1_1280"]
    let pursuitText = ["Learn to use Adobe", "From zero to director", "Graphic Design"]
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    func setupView(){
        addSubview(rowLabel)
        addSubview(collectionView)
        addSubview(showMoreButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        collectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 790)
        showMoreButton.anchor(top: collectionView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: showMoreButton.intrinsicContentSize.width, height: showMoreButton.intrinsicContentSize.height)
        showMoreButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomePursuitsListCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomePursuitsLists : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePursuitsListCells
        cell.photo.image = UIImage(named: pursuitImage[indexPath.item])
        cell.detailLabel.text = pursuitText[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 250)
    }
}
