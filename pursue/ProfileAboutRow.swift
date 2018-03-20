//
//  ProfileAboutRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/24/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileAboutRow : UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var user : User? {
        didSet{
            fullnameLabel.text = user?.fullname
            usernameLabel.text = user?.username
            userBio.text = user?.bio
            
            guard let follow = user?.followees else { return }
            followerArray = follow
            
            guard let following_count = user?.following_count else { return }
            guard let followers_count = user?.followers_count else { return }
            followingCount.text = String(describing: following_count)
            followersCount.text = String(describing: followers_count)
            
            if (following_count + followers_count) > 3 {
                let differenceLabel = (followers_count + following_count) - 3
                additionalFollowing.text = String(describing: differenceLabel)
            } else {
                additionalFollowing.isHidden = true
                additionalPlusFollowing.isHidden = true
            }
            
            followingCollectionView.reloadData()
        }
    }

    let cellId = "cellId"
    
    var followerArray = [Follower]()
    var followImage : [String?] = []
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var notificationsBackground : CardView = {
        let view = CardView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleNotification))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var notificationImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "notification-bell").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleNotification))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let followersCount : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(followersSelected))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    let followersLabel : UILabel = {
       let label = UILabel()
        label.text = "Followers"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(followersSelected))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var followingCount : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(followersSelected))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var followingLabel : UILabel = {
        let label = UILabel()
        label.text = "Following"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(followersSelected))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var userBio : UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 12)
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 5
        
        let attrString = NSMutableAttributedString(string: "")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        tv.attributedText = attrString
        return tv
    }()
    
    lazy var followingCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(followersSelected))
        tap.numberOfTapsRequired = 1
        collectionView.addGestureRecognizer(tap)
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    lazy var followingTapBackground : UIButton = {
       let view = UIButton()
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(followersSelected), for: .touchUpInside)
        return view
    }()
    
    lazy var additionalFollowing : UILabel = {
        let label = UILabel()
        label.text = ""
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(followersSelected))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var additionalPlusFollowing : UILabel = {
       let label = UILabel()
        label.text = "+"
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(followersSelected))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    let followId = "followId"
    
    var accessProfileController : ProfileController?
    
    @objc func followersSelected(){
        accessProfileController?.showFriendsController()
    }
    
    @objc func handleNotification(){
        accessProfileController?.showNotifications()
    }
    
    func setupFollowingView(){
        followingCollectionView.delegate = self
        followingCollectionView.dataSource = self
        followingCollectionView.register(FollowingCells.self, forCellWithReuseIdentifier: followId)
        addSubview(followingCollectionView)
        addSubview(additionalFollowing)
        addSubview(additionalPlusFollowing)
        
        followingCollectionView.anchor(top: usernameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 100, height: 80)
        additionalFollowing.anchor(top: nil, left: followingCollectionView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: additionalFollowing.intrinsicContentSize.width, height: additionalFollowing.intrinsicContentSize.height)
        additionalFollowing.centerYAnchor.constraint(equalTo: followingCollectionView.centerYAnchor).isActive = true
        additionalPlusFollowing.anchor(top: nil, left: additionalFollowing.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: additionalPlusFollowing.intrinsicContentSize.width, height: additionalPlusFollowing.intrinsicContentSize.height)
        additionalPlusFollowing.centerYAnchor.constraint(equalTo: additionalFollowing.centerYAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 12) - 15, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: followId, for: indexPath) as! FollowingCells
        
        if !followerArray.isEmpty {
            cell.imageView.loadImage(urlString: followerArray[indexPath.item].photoUrl!)
        }
        return cell
    }
    
    func setupFollowSystem(){
        addSubview(followersCount)
        addSubview(followersLabel)
        addSubview(followingCount)
        addSubview(followingLabel)
        addSubview(userBio)
        
        followingLabel.anchor(top: notificationsBackground.bottomAnchor, left: nil, bottom: nil, right: notificationsBackground.rightAnchor, paddingTop: 54, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: followingLabel.intrinsicContentSize.width, height: followingLabel.intrinsicContentSize.height)
        followingCount.anchor(top: followersCount.topAnchor, left: nil, bottom: followingLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 6, paddingRight: 0, width: followingCount.intrinsicContentSize.width, height: followingCount.intrinsicContentSize.height)
        followingCount.centerXAnchor.constraint(equalTo: followingLabel.centerXAnchor).isActive = true
        
        
        followersLabel.anchor(top: followingLabel.topAnchor, left: nil, bottom: nil, right: followingLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 54, width: followersLabel.intrinsicContentSize.width, height: followersLabel.intrinsicContentSize.height)
        followersCount.anchor(top: nil, left: nil, bottom: followersLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 6, paddingRight: 0, width: followersCount.intrinsicContentSize.width, height: followersCount.intrinsicContentSize.height)
        followersCount.centerXAnchor.constraint(equalTo: followersLabel.centerXAnchor).isActive = true
        
        setupFollowingView()
        addSubview(followingTapBackground)
        
        followingTapBackground.anchor(top: followingCount.topAnchor, left: leftAnchor, bottom: followingLabel.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userBio.anchor(top: followingCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: notificationsBackground.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        textViewDidChange(userBio)
    }
    
    func setupView(){
        addSubview(fullnameLabel)
        addSubview(usernameLabel)
        addSubview(notificationsBackground)
        addSubview(notificationImageView)
        
        fullnameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        notificationsBackground.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
        notificationImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        notificationImageView.centerXAnchor.constraint(equalTo: notificationsBackground.centerXAnchor).isActive = true
        notificationImageView.centerYAnchor.constraint(equalTo: notificationsBackground.centerYAnchor).isActive = true
        setupFollowSystem()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileAboutRow : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width - 24, height: .infinity)
        
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            constraint.constant = estimatedSize.height
        }
    }
}
