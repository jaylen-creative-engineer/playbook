//
//  PostSteps.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/18/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitSteps :  UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellId = "cellId"
    
    var accessPursuitDetailController : PursuitsDetailController?
    
    let pursuitSteps : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let stepsLabel : UILabel = {
       let label = UILabel()
        label.text = "Steps To Take"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let downArrow : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "expand_arrow1600").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    func setupView(){
        let underlineView = UIView()
        underlineView.backgroundColor = .gray
        
        addSubview(downArrow)
        addSubview(stepsLabel)
        addSubview(pursuitSteps)
        addSubview(underlineView)
        
        stepsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: stepsLabel.intrinsicContentSize.width, height: stepsLabel.intrinsicContentSize.height)
        downArrow.anchor(top: stepsLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 14, width: 25, height: 25)
        pursuitSteps.anchor(top: stepsLabel.bottomAnchor, left: stepsLabel.leftAnchor, bottom: nil, right: downArrow.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 30)
        underlineView.anchor(top: pursuitSteps.bottomAnchor, left: stepsLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostStepsCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 48, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        pursuitSteps.dataSource = self
        pursuitSteps.delegate = self
        pursuitSteps.register(PostStepsCells.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
