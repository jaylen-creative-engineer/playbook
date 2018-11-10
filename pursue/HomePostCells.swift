//
//  HomePostCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero

class HomePostCells : UICollectionViewCell  {
    
    var post : Post!{
        didSet {
            guard let photo = post.thumbnailUrl else { return }
            imageView.loadImageUsingCacheWithUrlString(photo)
            postDetail.text = post.posts_description
//            guard let timeAgoDisplay = post.created_at?.timeAgoDisplay() else { return }
//            let attributedText = NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
//            timeLabel.attributedText = attributedText
        }
    }
    
    var home : Home! {
        didSet {
            guard let postUser = home.photoUrl else { return }
            userPhoto.loadImageUsingCacheWithUrlString(postUser)
            username.text = home.username
        }
    }
    
    var accessHomeController : HomeController?
    
    lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangeDetail))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let backgroundShadow : GroupChatView = {
       let view = GroupChatView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        label.textAlignment = .center
        return label
    }()
    
    let username : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .white
        return label
    }()
    
    let progressBar : UIProgressView = {
       let view = UIProgressView()
        view.progress = 100
        view.progressTintColor = .white
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let progressStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .fill
        sv.spacing = 5
        return sv
    }()
    
    var stories = [Story]()
    
    var accessFeedController : FeedCell?
    
    @objc func handleChangeDetail(){
        accessHomeController?.handleChangeToDetail(transitionId: "0")
    }
    
    fileprivate func setupMultipleProgressBar() {
        addSubview(progressStackView)
        
        progressStackView.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 2.5)
        
        let gaps = self.stories.count
        let viewWidth = self.progressStackView.frame.width - CGFloat(gaps)
        let viewUnit = Int(viewWidth) / (stories.count + 1)
        for _ in stories {
            let progressView = UIProgressView()
            progressView.progress = 0
            progressView.layer.cornerRadius = 2
            progressView.layer.masksToBounds = true
            progressView.trackTintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
            progressView.progressTintColor = UIColor.white
            progressView.widthAnchor.constraint(equalToConstant: CGFloat(viewUnit)).isActive = true
            self.progressStackView.addArrangedSubview(progressView)
        }
    }

    func setupView(){
        addSubview(backgroundShadow)
        addSubview(imageView)
        addSubview(progressBar)
        addSubview(userPhoto)
        addSubview(postDetail)
        addSubview(username)
        addSubview(timeLabel)
        
        backgroundShadow.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: frame.height)
        imageView.anchor(top: backgroundShadow.topAnchor, left: backgroundShadow.leftAnchor, bottom: backgroundShadow.bottomAnchor, right: backgroundShadow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupMultipleProgressBar()
        userPhoto.anchor(top: progressStackView.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        username.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 16)
        timeLabel.anchor(top: username.bottomAnchor, left: username.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postDetail.anchor(top: nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 18, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hero.isEnabled = true
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
