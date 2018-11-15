//
//  PostComments.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/15/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostResponses: UICollectionViewCell {
    
    var responses : [Post]? {
        didSet {
            for value in responses ?? [] {
                if value.postId == nil {
                    addSubview(noResponses)
                    noResponses.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                    noResponses.anchor(top: responsesLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: noResponses.intrinsicContentSize.width, height: 18)
                    viewMoreButton.isHidden = true
                }
            }
            
            responsesCollectionView.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    let responsesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let responsesLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Responses"
        return label
    }()
    
    let noResponses : UILabel = {
       let label = UILabel()
        label.text = "No Responses Yet"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var viewMoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("View More", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(handleViewMore), for: .touchUpInside)
        return button
    }()
    
    var accessDetailController : PostDetailController?
    
    @objc func handleViewMore(){
        accessDetailController?.handleViewMoreResponses()
    }

    func setupView(){
        addSubview(responsesLabel)
        addSubview(responsesCollectionView)
        addSubview(viewMoreButton)
        
        responsesCollectionView.delegate = self
        responsesCollectionView.dataSource = self
        responsesCollectionView.register(PostResponsesCell.self, forCellWithReuseIdentifier: cellId)
        
        responsesLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: responsesLabel.intrinsicContentSize.width, height: 16)
        viewMoreButton.centerYAnchor.constraint(equalTo: responsesLabel.centerYAnchor).isActive = true
        viewMoreButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 34)
        responsesCollectionView.anchor(top: responsesLabel.topAnchor, left: responsesLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PostResponses : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responses?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostResponsesCell
        cell.post = responses?[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 120)
    }
}
