//
//  ProfilePursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuit : UICollectionViewCell {
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let cellId = "cellId"
    let imageName = [#imageLiteral(resourceName: "health")]
    let labelId = "labelId"
    var days = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]
    
    let labelCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let postCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupLabelCollection(){
        addSubview(labelCollectionView)
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.register(DayLabelCell.self, forCellWithReuseIdentifier: labelId)
        
        labelCollectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        labelCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }
    
    func setupView(){
        addSubview(rowLabel)
        addSubview(postCollectionView)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        setupLabelCollection()
        postCollectionView.anchor(top: labelCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 370)
        
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(ProfilePursuitCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfilePursuit : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case labelCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelId, for: indexPath) as! DayLabelCell
            cell.dayLabel.text = days[indexPath.item]
            return cell
        case postCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePursuitCells
            cell.photo.image = #imageLiteral(resourceName: "health")
            return cell
        default:
            assert(false, "Not a valid collection")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case labelCollectionView:
            return UIEdgeInsetsMake(0, 12, 0, -12)
        case postCollectionView:
            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        default:
            assert(false, "Not a valid collection")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case labelCollectionView:
            return CGSize(width: 60, height: 24)
        case postCollectionView:
            return CGSize(width: frame.width - 155, height: 360)
        default:
            assert(false, "Not a valid collection")
        }
    }
}
