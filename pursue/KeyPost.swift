//
//  KeyPost.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol KeyPostDelegate {
    func viewMore(for cell : KeyPost)
    func handleKeyPostSave(for cell : KeyPost)
}

class KeyPost : UICollectionViewCell, KeyPostCellsDelegate {
    
    var keyPost : [Post]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var delegate : KeyPostDelegate?
    var accessDetailController : PostDetailController?
    
    let keyPostLabel : UILabel = {
        let label = UILabel()
        label.text = "Key Steps"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let shadowView : KeyPostTopView = {
       let view = KeyPostTopView()
        view.backgroundColor = .white
        return view
    }()
    
    let topShadowView : KeyPostBottomView = {
       let view = KeyPostBottomView()
        view.backgroundColor = .white
        return view
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    lazy var viewMoreButton : UIButton = {
       let button = UIButton()
        button.setTitle("View More", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleViewMore), for: .touchUpInside)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let cellId = "cellId"
    
    @objc func handleViewMore(){
        delegate?.viewMore(for: self)
    }
    
    func setupView(){
        addSubview(keyPostLabel)
        addSubview(shadowView)
        addSubview(topShadowView)
        addSubview(collectionView)
        addSubview(viewMoreButton)
        
        keyPostLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: keyPostLabel.intrinsicContentSize.width, height: 18)
        shadowView.anchor(top: keyPostLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        topShadowView.anchor(top: shadowView.topAnchor, left: shadowView.leftAnchor, bottom: shadowView.bottomAnchor, right: shadowView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(KeyPostCells.self, forCellWithReuseIdentifier: cellId)
        collectionView.anchor(top: topShadowView.topAnchor, left: topShadowView.leftAnchor, bottom: nil, right: topShadowView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.height - 40)
        
        viewMoreButton.anchor(top: nil, left: nil, bottom: topShadowView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 120, height: 34)
        viewMoreButton.centerXAnchor.constraint(equalTo: topShadowView.centerXAnchor).isActive = true
    }
    
    
    func handleSave(for cell: KeyPostCells) {
        delegate?.handleKeyPostSave(for: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KeyPost : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyPost?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! KeyPostCells
        cell.delegate = self
        cell.post = keyPost?[indexPath.item]
        cell.countLabel.text = String(indexPath.item + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40, height: 85)
    }
}
