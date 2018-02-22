//
//  HomeInterestsRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/18/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeInterestsRow : UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var accessHomeController : HomeController?
    
    let interestsNames = ["Your Picks", "Adventure", "Animals", "Business", "Cars", "Design", "Finance"]
    
    let cellId = "cellId"
    
    let labelCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let approximateWidthOfCell = frame.width
        let size = CGSize(width: approximateWidthOfCell, height: .infinity)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        let estimatedFrame = NSString(string: interestsNames[indexPath.item]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: estimatedFrame.width + 32, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func homeTapped() {
    }
    
    func homeHeld() {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeInterestsCells
        cell.selectInterests.text = interestsNames[indexPath.item]
        return cell
    }
    
    var labelLeading : NSLayoutConstraint?
    var labelTrailing : NSLayoutConstraint?

    func setupView(){
        addSubview(labelCollection)
        
        labelLeading = labelCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        labelTrailing = labelCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        labelCollection.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        labelTrailing?.isActive = true
        labelLeading?.isActive = true
        
        labelCollection.showsHorizontalScrollIndicator = false
        labelCollection.translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelCollection.register(HomeInterestsCells.self, forCellWithReuseIdentifier: cellId)
        labelCollection.dataSource = self
        labelCollection.delegate = self
        setupView()
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        labelCollection.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
