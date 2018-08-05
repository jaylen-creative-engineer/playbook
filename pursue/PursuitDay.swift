//
//  PursuitDay.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import PinterestSegment

class PursuitDay : UICollectionViewCell {
    
    let labelId = "labelId"
    
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
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let cellId = "cellId"
    
    var days = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]
    let images = ["788572ee949285fae33dca5d846a4664", "clean-2", "academics", "fashion-design", "690dae66bfe860df34fc7a756b53c15d"]
    
    func setupPostCollection(){
        addSubview(postCollectionView)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(PursuitDayCells.self, forCellWithReuseIdentifier: cellId)
        
        postCollectionView.anchor(top: labelCollectionView.bottomAnchor, left: labelCollectionView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 480)
    }
    
    
    func setupLabelCollection(){
        addSubview(labelCollectionView)
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.register(DayLabelCell.self, forCellWithReuseIdentifier: labelId)
        
        labelCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        labelCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        setupPostCollection()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabelCollection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PursuitDay : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case labelCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelId, for: indexPath) as! DayLabelCell
            cell.dayLabel.text = days[indexPath.item]
            return cell
        case postCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PursuitDayCells
            cell.photo.image = UIImage(named: images[indexPath.item])
            return cell
        default:
            assert(false, "Not a valid collection")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case labelCollectionView:
            return UIEdgeInsetsMake(0, 24, 0, -24)
        default:
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case labelCollectionView:
            return CGSize(width: 60, height: 24)
        case postCollectionView:
            return CGSize(width: frame.width, height: 105)
        default:
            assert(false, "Not a valid collection")
        }
    }
}
