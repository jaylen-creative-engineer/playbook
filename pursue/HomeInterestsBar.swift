//
//  HomeInterestsBar.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/14/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeInterestsBar : UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let homeCellId = "homeCellId"
    let homeInterestsNames = ["Your Picks", "Adventure", "Animals", "Business", "Cars", "Design", "Finance"]
    var accessHomeController : HomeController?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let approximateWidthOfCell = frame.width
        let size = CGSize(width: approximateWidthOfCell, height: .infinity)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        let estimatedFrame = NSString(string: homeInterestsNames[indexPath.item]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: estimatedFrame.width + 32, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeInterestsNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let _ = homeInterestsNames.first {
            return UIEdgeInsetsMake(0, 18, 0, 12)
        }
        
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomeInterestsCells
        cell.interestsLabel.text = homeInterestsNames[indexPath.item]
        return cell
    }
    
    var labelLeading : NSLayoutConstraint?
    var labelTrailing : NSLayoutConstraint?
    
    func setupView(){
        addSubview(homeCollectionView)
        homeCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        homeCollectionView.register(HomeInterestsCells.self, forCellWithReuseIdentifier: homeCellId)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        homeCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
