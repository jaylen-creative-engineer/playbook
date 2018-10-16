//
//  CommentsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class CommentsController : UICollectionViewController {
    
    let commentsLabel = UILabel()
    let usernameLabel = UILabel()
    let navBarBackground = UIView()
    
    let navUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let headerId = "headerId"
    let cellId = "cellId"
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupCollectionView(){
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets.init(top: 60, left: 0, bottom: 0, right: 0)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(PostCommentsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setupNavigationBar(){
        navBarBackground.backgroundColor = .white
        navBarBackground.translatesAutoresizingMaskIntoConstraints = false
        
        commentsLabel.text = "Comments"
        commentsLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(navBarBackground)
        view.addSubview(navUnderlineView)
        navBarBackground.addSubview(backButton)
        navBarBackground.addSubview(commentsLabel)
        
        navBarBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        navUnderlineView.anchor(top: navBarBackground.bottomAnchor, left: navBarBackground.leftAnchor, bottom: nil, right: navBarBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        backButton.anchor(top: nil, left: navBarBackground.leftAnchor, bottom: navUnderlineView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 0, width: 16, height: 16)
        commentsLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        commentsLabel.anchor(top: nil, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: commentsLabel.intrinsicContentSize.width, height: commentsLabel.intrinsicContentSize.height)
    }
    
    lazy var containerView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 90)
        let commentInputAccessoryView = CommentInputAccessoryView(frame: frame)
        commentInputAccessoryView.backgroundColor = .clear
        //        commentInputAccessoryView.delegate = self
        return commentInputAccessoryView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
    }
}

extension CommentsController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCommentsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 130)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
}

