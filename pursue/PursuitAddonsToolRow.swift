//
//  PursuitAddonsToolRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitAddonsToolRow : UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let collectionViewContainer : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    let toolLabel : UILabel =  {
        let label = UILabel()
        label.text = "TOOLS"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let toolId = "toolId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 5) + 100, height: ((frame.width - 2) / 5) + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toolId, for: indexPath) as! ToolsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 0)
    }
    
    func setupView(){
        addSubview(toolLabel)
        addSubview(collectionViewContainer)
        
        toolLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 134, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        collectionViewContainer.anchor(top: toolLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 164)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        collectionViewContainer.register(ToolsCell.self, forCellWithReuseIdentifier: toolId)
        collectionViewContainer.delegate = self
        collectionViewContainer.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
