//
//  DetailSeasonFooter.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/9/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailSeasonHeader : UICollectionViewCell {
    
    let cellId = "cellId"
    
    let seasonLabel : UILabel = {
       let label = UILabel()
        label.text = "Season 1"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        return cv
    }()
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailSeasonDayCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.anchor(top: seasonLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupView(){
        addSubview(seasonLabel)
        
        seasonLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: seasonLabel.intrinsicContentSize.width, height: 18)
        setupCollectionView()
    }
    
    func scrollToMenuIndex(menuIndex : Int){
        print(menuIndex)
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailSeasonHeader : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailSeasonDayCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height - 30)
    }
}

class DetailSeasonDayCell : UICollectionViewCell {
    
    let pursuitImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let pursuitDescriptionLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize : 14)
        label.text = "This is filler text"
        return label
    }()
    
    let pursuitDayCount : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize : 12)
        label.text = "6 Days"
        return label
    }()
    
    let descriptionStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    func setupView(){
        addSubview(pursuitImageView)
        addSubview(descriptionStackView)
        
        descriptionStackView.addArrangedSubview(pursuitDescriptionLabel)
        descriptionStackView.addArrangedSubview(pursuitDayCount)
        
        pursuitImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 175, height: 0)
        descriptionStackView.anchor(top: pursuitImageView.topAnchor, left: pursuitImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        descriptionStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 80).isActive = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
