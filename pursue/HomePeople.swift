//
//  HomePeople.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomePeople : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var principlesDelegate : HomePrinciplesDelegate?
    var accessHomeController : HomeContainer?
    
    let profileImageNames = ["realist", "inheritance", "value-first", "menu-numbers"]
    let profileLabelText = ["Naive Realism", "Treat others like they control your inheritance","Show value upfront", "Organize and label menu categories"]
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let peopleCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var addButton : UIButton = {
       let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var addIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePeopleCells
        rowLabel.text = "Following"
        cell.usernameLabel.text = profileLabelText[indexPath.item]
        cell.profileImage.image = UIImage(named: profileImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func setupView(){
        addSubview(rowLabel)
        addSubview(peopleCollection)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        peopleCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        peopleCollection.showsVerticalScrollIndicator = false
        peopleCollection.register(HomePeopleCells.self, forCellWithReuseIdentifier: cellId)
        peopleCollection.dataSource = self
        peopleCollection.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
