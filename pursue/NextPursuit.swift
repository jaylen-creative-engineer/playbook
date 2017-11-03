//
//  NextPursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/18/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class NextPursuit : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let pursuitSteps : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let cellId = "cellId"
    
    func setupView(){
        addSubview(pursuitSteps)
        pursuitSteps.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NextPursuitCellsContainer
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        pursuitSteps.delegate = self
        pursuitSteps.dataSource = self
        pursuitSteps.register(NextPursuitCellsContainer.self, forCellWithReuseIdentifier: cellId)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
