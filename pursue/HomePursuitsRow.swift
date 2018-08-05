//
//  HomePursuitsRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero
import Firebase

class HomePursuitsRow : UICollectionViewCell, HomePursuitsDelegate {
    
    let rowLabel : UILabel = {
       let label = UILabel()
        label.text = "My Pursuits."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    var accessHomeController : HomeController?
    
    let cellId = "cellId"
    
    let imageName = [#imageLiteral(resourceName: "health"), #imageLiteral(resourceName: "fashion-design"), #imageLiteral(resourceName: "ferrari-f70"), #imageLiteral(resourceName: "ferrari")]
    let userPhotos = [#imageLiteral(resourceName: "clean-3"),#imageLiteral(resourceName: "clean-2"),#imageLiteral(resourceName: "comment-2"), #imageLiteral(resourceName: "comment-6")]
    
    let collectionView : UICollectionView = {
        let layout = PinterestLayout()
        layout.numberOfColumns = 2

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var showMoreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "expand_arrow1600").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleShowMore), for: .touchUpInside)
        return button
    }()
    
    @objc func goToFeed(){
        accessHomeController?.goToFeedView()
    }
    
    @objc func handleShowMore(){
        Analytics.logEvent("Selected show more for \(String(describing: rowLabel.text))", parameters: nil)
    }
    
    func setupView(){
        addSubview(rowLabel)
        addSubview(collectionView)
        addSubview(showMoreButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        collectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 485)
        showMoreButton.anchor(top: collectionView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 18, height: 24)
        showMoreButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        isHeroEnabled = true
        collectionView.register(HomePursuitsCells.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    
    func handleHold(for cell: HomePursuitsCells) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        accessHomeController?.postHeld(transitionId: String(indexPath.item))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomePursuitsRow : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePursuitsCells
        cell.delegate = self
        cell.accessHomePursuitsRow = self
        cell.photo.heroID = String(indexPath.item)
        cell.photo.image = imageName[indexPath.item]
        cell.userPhoto.image = userPhotos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail", transitionId: String(indexPath.item))
        Analytics.logEvent("Change to detail for \(String(describing: rowLabel.text))", parameters: nil)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
}

extension HomePursuitsRow : PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 110
        } else {
            return 105
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 110
        } else {
            return 105
        }
    }
}
