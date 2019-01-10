//
//  DetailIssuesFooter.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/9/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailIssuesFooter : UICollectionViewCell {
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        return cv
    }()
    
    let responsesLabel : UILabel = {
       let label = UILabel()
        label.text = "Responses"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let cellId = "cellId"
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailIssuesFooterCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(responsesLabel)
        addSubview(collectionView)
        
        responsesLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: responsesLabel.intrinsicContentSize.width, height: 16)
        collectionView.anchor(top: responsesLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailIssuesFooter : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailIssuesFooterCell
        return cell
    }
}

class DetailIssuesFooterCell : UICollectionViewCell {
    
    let cellBackgroundView : SolutionCardView = {
        let view = SolutionCardView()
        view.backgroundColor = .white
        return view
    }()
    
    let dayImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let dayLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let pursuitLabel : UILabel = {
        let label = UILabel()
        label.text = "Getting into an art gallery"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(dayImageView)
        addSubview(dayLabel)
        addSubview(pursuitLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        dayImageView.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: cellBackgroundView.bottomAnchor, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dayLabel.anchor(top: dayImageView.bottomAnchor, left: dayImageView.leftAnchor, bottom: nil, right: dayImageView.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        pursuitLabel.anchor(top: dayLabel.bottomAnchor, left: dayLabel.leftAnchor, bottom: nil, right: dayLabel.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
