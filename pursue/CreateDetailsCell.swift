//
//  CreateDetailsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CreateDetailsCell : UICollectionViewCell {
    
    let interestsLabel : UILabel = {
        let label = UILabel()
        label.text = "Choose Interests"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "Post Type"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let selectInterests : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
        return cv
    }()
    
    let addCaptionTextView : CaptionInputTextView = {
        let tv = CaptionInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let userCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 12)
        return cv
    }()
    
    let principleButton : UIButton = {
        let button = UIButton()
        button.setTitle("Principle", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.init(white: 0.6, alpha: 0.3)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var challengeButton : UIButton = {
        let button = UIButton()
        button.setTitle("Challenge", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.init(white: 0.6, alpha: 0.3)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let stepButton : UIButton = {
        let button = UIButton()
        button.setTitle("Step", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.init(white: 0.6, alpha: 0.3)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let teamId = "teamId"
    let interestsId = "interestsId"
    
    var interests = [CreateInterests]()
    let interestsService = InterestServices()
    var accessPhotoViewController : PhotoViewController?
    
    func getInterests(){
        interestsService.getInterestsNames { (interest) in
            DispatchQueue.main.async {
                self.interests = interest
                self.selectInterests.reloadData()
            }
        }
    }
    
    func setupPostTypeCollectionView(){
        let stackView = UIStackView(arrangedSubviews: [challengeButton, principleButton, stepButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postTypeLabel)
        addSubview(stackView)
        
        postTypeLabel.anchor(top: selectInterests.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        stackView.anchor(top: postTypeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: frame.width / 1.3, height: 30)
        
    }
    
    func setupTeamCollectionView(){
        addSubview(addCaptionTextView)
        addSubview(userCollectionView)
        
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.register(CreateTeamCells.self, forCellWithReuseIdentifier: teamId)
        addCaptionTextView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 45)
        userCollectionView.anchor(top: addCaptionTextView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        setupSelectInterests()
    }
    
    func setupSelectInterests(){
        addSubview(interestsLabel)
        addSubview(selectInterests)
        
        selectInterests.delegate = self
        selectInterests.dataSource = self
        selectInterests.register(CreateInterestsCells.self, forCellWithReuseIdentifier: interestsId)
        
        interestsLabel.anchor(top: userCollectionView.bottomAnchor, left: addCaptionTextView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: interestsLabel.intrinsicContentSize.width, height: 16)
        
        selectInterests.anchor(top: interestsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        setupPostTypeCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTeamCollectionView()
        getInterests()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateDetailsCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case selectInterests:
            return interests.count
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case selectInterests:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestsId, for: indexPath) as! CreateInterestsCells
            cell.interest = interests[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! CreateTeamCells
            cell.accessDetailController = self
            switch indexPath.item {
            case 0:
                cell.setupFriendsSearch()
            default:
                cell.setupView()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case selectInterests:
            if let interest_name = interests[indexPath.item].interest_name {
                let approximateHeightOfLabel = frame.width - 20 - 8
                let size = CGSize(width: .infinity, height: approximateHeightOfLabel)
                let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
                let estimatedFrame = NSString(string: interest_name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: estimatedFrame.width + 50, height: 43)
            }
            return CGSize(width: frame.width / 4, height: 40)
        default:
            switch indexPath.item {
            case 0:
                return CGSize(width: 90, height: 45)
            default:
                return CGSize(width: 40, height: 45)
            }

        }
    }
}
