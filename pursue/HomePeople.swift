//
//  HomePeople.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase

class HomePeople : UICollectionViewCell {
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.text = "People."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let cellId = "cellId"
    
    let peopleFullname = ["Tom Ford", "Versace", "LVME", "Test", "Lit"]
    let peopleUsernames = ["TomFord123", "Versace", "LVME", "Test", "Lit"]
    let peopleImages = ["comment-1", "comment-4", "comment-7", "clean-2", "clean-3"]
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupView(){
        addSubview(rowLabel)
        addSubview(collectionView)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        collectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 28, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.register(HomePeopleCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//extension HomePeople : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePeopleCells
//        cell.profileImage.image = UIImage(named: peopleImages[indexPath.item])
//        cell.usernameLabel.text = peopleUsernames[indexPath.item]
//        cell.fullnameLabel.text = peopleFullname[indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        Analytics.logEvent("Change to detail for \(String(describing: rowLabel.text))", parameters: nil)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 80, height: 200)
//    }
//}
