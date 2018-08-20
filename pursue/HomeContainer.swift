//
//  HomeContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeContainer : UICollectionViewCell {
    
    let postId = "postId"
    let cellId = "cellId"
    let labelId = "labelId"
    let peopleId = "peopleId"
    let headerId = "headerId"
    let interestId = "interestId"
    let picksId = "picksId"
    
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    var interestsLabel = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]

    func setupPostCollection(){
        addSubview(postCollectionView)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(HomePostRow.self, forCellWithReuseIdentifier: postId)
        postCollectionView.anchor(top: labelCollectionView.bottomAnchor, left: labelCollectionView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.height + 40)
    }
    
    
    func setupLabelCollection(){
        addSubview(labelCollectionView)
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.register(InterestsLabelCell.self, forCellWithReuseIdentifier: labelId)
        
        labelCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        labelCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        setupPostCollection()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLabelCollection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension HomeContainer : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case labelCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelId, for: indexPath) as! InterestsLabelCell
            cell.interestsLabel.text = interestsLabel[indexPath.item]
            return cell
        case postCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! HomePostRow
            cell.postTableView.reloadData()
            return cell
        default:
            assert(false, "Not a valid collection")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case labelCollectionView:
            return UIEdgeInsetsMake(0, 14, 0, -14)
        default:
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case labelCollectionView:
            return CGSize(width: 60, height: 24)
        case postCollectionView:
            return CGSize(width: frame.width, height: frame.height + 20)
        default:
            assert(false, "Not a valid collection")
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == postCollectionView{
            let currentpage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
            let cellIndexPath = IndexPath(row: currentpage, section: 0)
            labelCollectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredVertically)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == labelCollectionView{
            let cellIndexPath = IndexPath(row: indexPath.row, section: 0)
            postCollectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}
