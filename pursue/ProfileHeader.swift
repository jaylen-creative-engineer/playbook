//
//  ProfileHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate {
    func showNotifications()
    func handleSettings()
}

class ProfileHeader : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var accessHomeController : HomeController?
    var delegate : ProfileHeaderDelegate?
    
    var user : User? {
        didSet {
            guard let imageUrl = user?.photoUrl else { return }
            photoImageView.loadImageUsingCacheWithUrlString(imageUrl)
            fullnameLabel.text = user?.fullname
        }
    }
    
    let cellId = "cellId"
    
    
    lazy var settingsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    lazy var notificationsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bell").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleNotifications), for: .touchUpInside)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var settingsBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        return button
    }()
    
    let photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        let attrString = NSMutableAttributedString(string: "")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
        return label
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Trained To Glory"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameAstric : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var userBio : UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let attrString = NSMutableAttributedString(string: "Here is some sample text that I am putting right here just to see how to bio text field looks, with some live data.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        tv.attributedText = attrString
        return tv
    }()
    
    let pursuitsLabel : UILabel = {
        let label = UILabel()
        label.text = "165"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let postsLabel : UILabel = {
        let label = UILabel()
        label.text = "247"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    let principleLabel : UILabel = {
        let label = UILabel()
        label.text = "655"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let addedLabel : UILabel = {
       let label = UILabel()
        label.text = "25"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let countsArray = ["165", "247", "553"]
    let labelArray = ["Posts", "Pursuits", "Principles"]
    
    let statsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StatsCells
        cell.countLabel.text = countsArray[indexPath.item]
        cell.contentTypeLabel.text = labelArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 6, 0, 10)
    }
    
    var accessProfileController : ProfileController?
    
    @objc func handleSettings() {
        delegate?.handleSettings()
    }
    
    @objc func handleNotifications(){
        accessProfileController?.showNotifications()
    }
    
    
    func setupProfileOptions(){
        addSubview(settingsButton)
        addSubview(notificationsButton)
        notificationsButton.anchor(top: usernameAstric.bottomAnchor, left: usernameAstric.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 19, height: 24)
        settingsButton.anchor(top: notificationsButton.topAnchor, left: notificationsButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 21, height: 21)
    }
    
    func setupView(){
        addSubview(photoImageView)
        addSubview(fullnameLabel)
        addSubview(usernameAstric)
        addSubview(usernameLabel)
        addSubview(userBio)
        addSubview(statsCollection)
        
        photoImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 100, height: 100)
        fullnameLabel.anchor(top: photoImageView.topAnchor, left: leftAnchor, bottom: nil, right: photoImageView.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: fullnameLabel.intrinsicContentSize.height)
        usernameAstric.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        usernameLabel.anchor(top: nil, left: usernameAstric.rightAnchor, bottom: nil, right: fullnameLabel.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        usernameLabel.centerYAnchor.constraint(equalTo: usernameAstric.centerYAnchor).isActive = true
        userBio.anchor(top: photoImageView.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: photoImageView.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: userBio.intrinsicContentSize.height)
        statsCollection.backgroundColor = .red
        statsCollection.anchor(top: userBio.bottomAnchor, left: userBio.leftAnchor, bottom: nil, right: userBio.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        textViewDidChange(userBio)
        setupProfileOptions()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        statsCollection.register(StatsCells.self, forCellWithReuseIdentifier: cellId)
        statsCollection.delegate = self
        statsCollection.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ProfileHeader : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width - 24, height: .infinity)
        
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
