//
//  PursuitsDetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Gifu


protocol MessageDelegate {
    func handleMessage(for cell : PursuitsDetailHeader)
    func goBack()
}

class PursuitsDetailHeader : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var isAboutView = true
    var isSavedView = false
    var isToolsView = false
    var isTeamView = false
    var isNextView = false
    var isStepsView = false
    var isChallenge = false
    
    var pursuitsDetailController : PursuitsDetailController?
    var messageDelegate : MessageDelegate?
    
    let headerId = "headerId"
    let bottomDividerView = UIView()
    
    let aboutLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let stepsLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let discusionLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let savedLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let principleLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var likeIcon : UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.setImage(#imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        return button
    }()
    
    lazy var commentIcon : UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleComment), for: .touchUpInside)
        return button
    }()
    
    let likeCounter : UILabel = {
        let label = UILabel()
        label.text = "132"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleSave), for: .touchUpInside)
        return button
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var optionButton : UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleOptions), for: .touchUpInside)
        return button
    }()
    
    lazy var postDescription : UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        tv.attributedText = attrString
        return tv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Jubilee"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 25
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let scrollView = UIScrollView()

    @objc func dismissView(){
        messageDelegate?.goBack()
    }
    
    @objc func handleOptions(){
        pursuitsDetailController?.showStepOptions()
    }
    
    @objc func handleChat() {
        messageDelegate?.handleMessage(for: self)
    }

    
    var isSaved = false
    var isLiked = false
    var isComment = true
    
    @objc func toggleSave(){
        isSaved = !isSaved
        
        if isSaved == true {
            saveIcon.tintColor = .black
        } else {
            saveIcon.tintColor = .gray
        }
    }
    
    @objc func toggleComment(){
        isComment = !isComment
        
        if isComment == true {
            pursuitsDetailController?.containerView.isHidden = false
            commentIcon.tintColor = .black
            let indexPath = IndexPath(item: 2, section: 0)
            collectionView.scrollToItem(at: indexPath, at: [], animated: true)
        } else {
            pursuitsDetailController?.containerView.isHidden = true
            commentIcon.tintColor = .gray
        }
    }
    
    @objc func toggleLike(){
        isLiked = !isLiked
        if isLiked == true {
            likeIcon.tintColor = .black
            likeCounter.textColor = .black
        } else {
            likeIcon.tintColor = .gray
            likeCounter.textColor = .gray
        }
    }
    
    let cellId = "cellId"
    let stepsId = "stepsId"
    let principleId = "principleId"
    let commentsId = "commentsId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 390)
        case 1:
            return CGSize(width: frame.width, height: 330)
        case 2:
            let approximateWidthOfCell = frame.width
            let size = CGSize(width: approximateWidthOfCell, height: .infinity)
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
            let estimatedFrame = NSString(string: postDescription.text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: frame.width, height: estimatedFrame.height + 80)
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepsId, for: indexPath) as! DetailSteps
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PursuitPrinciple
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentsId, for: indexPath) as! PostComments
            return cell
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    let underlineView = UIView()

    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(DetailSteps.self, forCellWithReuseIdentifier: stepsId)
        collectionView.register(PursuitPrinciple.self, forCellWithReuseIdentifier: principleId)
        collectionView.register(PostComments.self, forCellWithReuseIdentifier: commentsId)
        
        addSubview(collectionView)
        collectionView.anchor(top: underlineView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.height)
    }
    
    func setupPostDescription(){
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(postDescription)
        
        userPhoto.anchor(top: optionButton.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
        
        underlineView.backgroundColor = .gray
        addSubview(underlineView)
        
        usernameLabel.anchor(top: userPhoto.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        if !postDescription.text.isEmpty {
            postDescription.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: userPhoto.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 14, width: postDescription.intrinsicContentSize.width, height: postDescription.intrinsicContentSize.height)
        }
        if postDescription.text.isEmpty {
            underlineView.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: userPhoto.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)
        } else {
            underlineView.anchor(top: postDescription.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: userPhoto.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)
        }
        
        setupCollectionView()
    }
    
    func setupEngagements(){
        addSubview(likeIcon)
        addSubview(commentIcon)
        addSubview(likeCounter)
        addSubview(saveIcon)

        likeIcon.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 20)
        likeCounter.anchor(top: likeIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: likeCounter.intrinsicContentSize.width, height: likeCounter.intrinsicContentSize.height)
        likeCounter.centerXAnchor.constraint(equalTo: likeIcon.centerXAnchor).isActive = true
        commentIcon.anchor(top: likeIcon.topAnchor, left: likeIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 24, height: 20)
        saveIcon.anchor(top: topAnchor, left: commentIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 22, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 22, height: 21)
        toggleLike()
        toggleSave()
        toggleComment()

        addSubview(optionButton)
        optionButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 44, height: optionButton.intrinsicContentSize.height)
        setupPostDescription()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEngagements()
        textViewDidChange(postDescription)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PursuitsDetailHeader : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width - 24, height: .infinity)
        
        // Calculating the height
        
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
