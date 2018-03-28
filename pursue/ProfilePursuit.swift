//
//  ProfilePursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuit : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var pursuit : Pursuit? {
        didSet {
            guard let photo = pursuit?.thumbnailUrl else { return }
            pursuitImage.image = UIImage(named: photo)?.withRenderingMode(.alwaysOriginal)
            pursuitLabel.text = pursuit?.pursuitDescription
        }
    }
    
    lazy var pursuitImage : UIImageView = {
       let iv = UIImageView()
        return iv
    }()
    
    lazy var pursuitLabel : UILabel = {
       let label = UILabel()
        return label
    }()
    
    var count : Int = 0
    
    var pursuits = [Pursuit]()
    var accessProfileController : ProfileController?
    let createId = "createId"
    
    let pursuitCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var pursuitsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Pursuits", for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.isUserInteractionEnabled = true
        label.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(25))
        return label
    }()
    
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 235, height: 335)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pursuits.count != 0 {
            return count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if pursuits.count != 0 {
            accessProfileController?.showCamera()
        } else {
            print("Nothing")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(pursuits)
        if pursuits.count != 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePursuitCells
            cell.pursuit = pursuits[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createId, for: indexPath) as! ProfilePursuitCreateCell
            return cell
        }
        
    }
    
    func setupView(){
        pursuitCollectionView.register(ProfilePursuitCells.self, forCellWithReuseIdentifier: cellId)
        pursuitCollectionView.register(ProfilePursuitCreateCell.self, forCellWithReuseIdentifier: createId)
        pursuitCollectionView.delegate = self
        pursuitCollectionView.dataSource = self
        
        addSubview(pursuitsLabel)
        addSubview(pursuitCollectionView)
        pursuitsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: pursuitsLabel.intrinsicContentSize.width, height: pursuitsLabel.intrinsicContentSize.height)
        pursuitCollectionView.anchor(top: pursuitsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 425)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        pursuitCollectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
