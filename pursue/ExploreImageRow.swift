//
//  ExploreRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExploreImageDelegate {
    func imageTapped()
    func imageHeld()
}

class ExploreImageRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var exploreDelegate : ExploreImageDelegate?
    var accessExploreController : ExploreController?
    let exploreImageNames = ["ferrari", "pagani", "ferrari-f70", "ghost"]
    let exploreLabelText = ["Ferrari", "Desvre", "La Ferrari F70", "Ghost"]
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Animal Pursuits"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()

    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleShowMore), for: .touchUpInside)
        return button
    }()
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    @objc func handleShowMore(){
        accessExploreController?.handleChangeToFeed(viewType: "isImageFeed")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) + 60, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExerciseImageCells
        cell.exploreImage.image = UIImage(named: exploreImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.exploreMainDescription.text = exploreLabelText[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func imageCellTapped() {
        exploreDelegate?.imageTapped()
    }
    
    func imageCellHeld() {
        exploreDelegate?.imageHeld()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        addSubview(postCollection)
        addSubview(rowLabel)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: 20)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 375)
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(ExerciseImageCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.delegate = self
        postCollection.dataSource = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
