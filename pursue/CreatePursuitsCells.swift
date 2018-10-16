//
//  CreatePursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CreatePursuitsCells : UICollectionViewCell {
    
    lazy var startPursuitButton : UIButton = {
       let button = UIButton()
        button.setTitle("Start New", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let choosePursuitButton : UILabel = {
       let label = UILabel()
        label.text = "Choose Pursuit"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let cellId = "cellId"
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CreateSelectPursuit.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(choosePursuitButton)
        addSubview(startPursuitButton)
        addSubview(collectionView)
        
        choosePursuitButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: choosePursuitButton.intrinsicContentSize.width + 10, height: 16)
        
        startPursuitButton.anchor(top: choosePursuitButton.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: startPursuitButton.intrinsicContentSize.width, height: 16)
        
        collectionView.anchor(top: choosePursuitButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreatePursuitsCells : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CreateSelectPursuit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 1.8), height: (frame.height / 1.6) - 60)
    }
}
