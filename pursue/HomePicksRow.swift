//
//  HomePicksRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomePicksRow : UICollectionViewCell {
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.text = "Top Picks."
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    let showAllButton : UIButton = {
        let button = UIButton()
        button.setTitle("Show All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.init(25))
        return button
    }()


    let principleId = "principleId"
    let stepId = "stepId"

    let principleImage = ["788572ee949285fae33dca5d846a4664", "clean-2", "academics", "fashion-design", "690dae66bfe860df34fc7a756b53c15d"]
    let stepImage = ["690dae66bfe860df34fc7a756b53c15d", "fashion-design", "788572ee949285fae33dca5d846a4664", "clean-2", "academics"]

    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    func setupView(){
        let underlineView = UIView()
        underlineView.backgroundColor = .black
        
        addSubview(rowLabel)
        addSubview(underlineView)
        addSubview(showAllButton)
        addSubview(collectionView)

        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        underlineView.anchor(top: nil, left: nil, bottom: rowLabel.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 48, height: 2)
        showAllButton.anchor(top: nil, left: underlineView.leftAnchor, bottom: underlineView.topAnchor, right: underlineView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        collectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomePrinciplesCells.self, forCellWithReuseIdentifier: principleId)
        collectionView.register(HomeStepCells.self, forCellWithReuseIdentifier: stepId)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomePicksRow : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0, 2, 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciplesCells
            cell.principleImage.image = UIImage(named: principleImage[indexPath.item])
            return cell
        case 1, 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! HomeStepCells
            cell.stepImage.image = UIImage(named: stepImage[indexPath.item])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciplesCells
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) - 30, height: 350)
    }
}
