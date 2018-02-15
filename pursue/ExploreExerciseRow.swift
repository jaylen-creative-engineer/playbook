//
//  ExploreChallengesRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/24/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExploreExerciseDelegate {
    func explorePursuitTapped()
    func explorePursuitHeld()
}

class ExploreExerciseRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ExploreExerciseCellsDelegate {
    
    var exploreDelegate : ExploreExerciseDelegate?
    var accessExploreController : ExploreController?
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleShowMore), for: .touchUpInside)
        return button
    }()
    
    let exploreImageNames = ["fire", "flights", "currency", "map"]
    let exerciseLabelText = ["Start a fire", "How to find cheaper flights?", "Converting your money", "How to read a map?"]

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
        accessExploreController?.handleChangeToFeed(viewType: "isPursuitFeed")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 65, height: ((frame.width - 2) / 2) + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreExercisesRowCells
        cell.exploreImage.image = UIImage(named: exploreImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.exploreLabel.text = exerciseLabelText[indexPath.item]
        cell.exploreExereciseDelegate = self
        rowLabel.text = "Pursuits"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func pursuitTapped() {
        exploreDelegate?.explorePursuitTapped()
    }
    
    func pursuitHeld() {
        exploreDelegate?.explorePursuitHeld()
    }
    
    func setupView(){
        addSubview(rowLabel)
        addSubview(postCollection)
        addSubview(moreButton)

        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: 45)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 255)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)

        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(ExploreExercisesRowCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.dataSource = self
        postCollection.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
