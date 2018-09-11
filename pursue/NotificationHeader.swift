//
//  NotificationHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase


class NotificationHeader : UICollectionViewCell {
    
    var accessNotificationController : NotificationsController?
    let headerId = "headerId"
    let cellId = "cellId"
    
    var headerNames = ["NOTIFICATIONS", "CHAT"]
    
    let labelCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    
    lazy var searchIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.motionIdentifier = "searchIcon"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSearchTap))
        tap.numberOfTapsRequired = 1
        button.addGestureRecognizer(tap)
        return button
    }()
    
    @objc func handleSearchTap(){
        accessNotificationController?.goToSearchController()
    }

    func setupLabelCollectionView(){
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.register(NotificationHeaderCells.self, forCellWithReuseIdentifier: cellId)
        addSubview(labelCollectionView)
        addSubview(searchIcon)
        labelCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        searchIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 9, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 18, height: 18)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        labelCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabelCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NotificationHeader : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NotificationHeaderCells
        cell.sectionLabel.text = headerNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let approximateWidthOfLabel = frame.width / 3.5
        let size = CGSize(width: approximateWidthOfLabel, height: .infinity)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let estimatedFrame = NSString(string: headerNames[indexPath.item]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: estimatedFrame.width + 10, height: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessNotificationController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
}
