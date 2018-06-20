//
//  SearchReturn.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchReturn : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var user : SearchedUsers? {
        didSet {
            guard let photo = user?.photoUrl else { return }
            userPhoto.loadImage(urlString: photo)
            usernameLabel.text = user?.username
            setupUserPhoto()
            
            if user?.username == nil {
                setupEmptyCheck()
            }
        }
    }
    
    var stepSampleImagesNames = ["fire", "flights", "currency", "map"]
    var stepSampleImagesText = ["Start a fire", "How to find cheaper flights?", "Converting your money", "How to read a map?"]
    
    var principleSampleImagesNames = ["mel-robbins", "menu-numbers", "go-back", "change-location"]
    var principleSampleImagesText = ["Show value upfront", "Organize and label menu categories", "Allow users to go back easily in one step.", "Make it easy to manually change location."]
    
    var usernameText = ["Vice", "Jubilee", "boldceo", "Soulection", "GQ"]
    var userImageArray = [#imageLiteral(resourceName: "profile-1"), #imageLiteral(resourceName: "profile-2"), #imageLiteral(resourceName: "profile-3"), #imageLiteral(resourceName: "profile-4"), #imageLiteral(resourceName: "profile-5")]
    
    var step : SearchedSteps? {
        didSet {
            stepCollectionView.reloadData()
        }
    }
    
    var principle : SearchedPrinciples? {
        didSet {
            principleCollectionView.reloadData()
        }
    }
    
    let peopleRowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "People"
        return label
    }()
    
    let stepRowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Steps"
        return label
    }()
    
    let principleRowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Principles"
        return label
    }()
    
    lazy var userPhoto : CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 40
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "profile-1").withRenderingMode(.alwaysOriginal)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap))
//        tapGesture.numberOfTapsRequired = 1
//        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Tom"
        return label
    }()
    
    let emptyLabel : UILabel = {
       let label = UILabel()
        label.text = "No results found."
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var principleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    lazy var stepCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    let usersId = "usersId"
    let pursuitsId = "pursuitsId"
    let principlesId = "principlesId"
    var steps = [SearchedSteps]()
    var principles = [SearchedPrinciples]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView {
//        case stepCollectionView:
//            if !steps.isEmpty {
//                return 3
//            } else {
//                return 0
//            }
//        case principleCollectionView:
//            if !principles.isEmpty {
//                return 3
//            } else {
//                return 0
//            }
//        default:
//            return 3
//        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case stepCollectionView:
            return CGSize(width: frame.width, height: 105)
        case principleCollectionView:
            return CGSize(width: frame.width, height: 105)
        default:
           return CGSize(width: frame.width, height: 105)
        }
    }
    
    let stepId = "stepId"
    let principleId = "principleId"
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case stepCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! HomeStepCells
            cell.pursuitLabel.text = stepSampleImagesText[indexPath.item]
            cell.pursuitImage.image = UIImage(named: stepSampleImagesNames[indexPath.item])
//            cell.step = step
            return cell
        case principleCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciplesCells
            cell.principleLabel.text = principleSampleImagesText[indexPath.item]
            cell.principleImage.image = UIImage(named: principleSampleImagesNames[indexPath.item])
//            cell.principle = principle
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciplesCells
            return cell
        }
    }
    
    func setupSampleView(){
        addSubview(peopleRowLabel)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(stepRowLabel)
        addSubview(stepCollectionView)
        addSubview(principleRowLabel)
        addSubview(principleCollectionView)
        
        stepCollectionView.delegate = self
        stepCollectionView.dataSource = self
        stepCollectionView.register(HomeStepCells.self, forCellWithReuseIdentifier: stepId)
        
        principleCollectionView.delegate = self
        principleCollectionView.dataSource = self
        principleCollectionView.register(HomePrinciplesCells.self, forCellWithReuseIdentifier: principleId)
        
        peopleRowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: peopleRowLabel.intrinsicContentSize.width, height: peopleRowLabel.intrinsicContentSize.height)
        userPhoto.anchor(top: peopleRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        usernameLabel.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        usernameLabel.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor).isActive = true
        stepRowLabel.anchor(top: usernameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: stepRowLabel.intrinsicContentSize.width, height: stepRowLabel.intrinsicContentSize.height)
        stepCollectionView.anchor(top: stepRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 320)
        principleRowLabel.anchor(top: stepCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: principleRowLabel.intrinsicContentSize.width, height: principleRowLabel.intrinsicContentSize.height)
        principleCollectionView.anchor(top: principleRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 320)
    }
    
    func setupUserPhoto(){
        addSubview(peopleRowLabel)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        
        guard let valueCheck = usernameLabel.text?.isEmpty else { return }
        
        switch valueCheck {
        case true:
            peopleRowLabel.isHidden = true
            userPhoto.isHidden = true
            usernameLabel.isHidden = true
        case false:
            peopleRowLabel.isHidden = false
            userPhoto.isHidden = false
            usernameLabel.isHidden = false
            peopleRowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: peopleRowLabel.intrinsicContentSize.width, height: peopleRowLabel.intrinsicContentSize.height)
            userPhoto.anchor(top: peopleRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
            usernameLabel.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
            usernameLabel.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor).isActive = true
        }
    }
    
    func setupStepCollection(){
        stepCollectionView.delegate = self
        stepCollectionView.dataSource = self
        stepCollectionView.register(HomeStepCells.self, forCellWithReuseIdentifier: pursuitsId)
        
        addSubview(stepRowLabel)
        addSubview(stepCollectionView)
        
        guard let valueCheck = usernameLabel.text?.isEmpty else { return }
        
        switch valueCheck {
        case true:
            stepRowLabel.isHidden = false
            stepCollectionView.isHidden = false
            stepRowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: stepRowLabel.intrinsicContentSize.width, height: stepRowLabel.intrinsicContentSize.height)
            stepCollectionView.anchor(top: stepRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 320)
        case false:
            stepRowLabel.isHidden = false
            stepCollectionView.isHidden = false
            stepRowLabel.anchor(top: usernameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: stepRowLabel.intrinsicContentSize.width, height: stepRowLabel.intrinsicContentSize.height)
            stepCollectionView.anchor(top: stepRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 320)
        }
    }
    
    func setupPrincipleCollection(){
        principleCollectionView.delegate = self
        principleCollectionView.dataSource = self
        principleCollectionView.register(HomePrinciplesCells.self, forCellWithReuseIdentifier: principlesId)
        
        addSubview(principleRowLabel)
        addSubview(principleCollectionView)
        switch steps.isEmpty {
        case true:
            if usernameLabel.text?.isEmpty == true {
                principleRowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: principleRowLabel.intrinsicContentSize.width, height: principleRowLabel.intrinsicContentSize.height)
                principleCollectionView.anchor(top: principleRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 320)
            } else if usernameLabel.text?.isEmpty == false {
                principleRowLabel.anchor(top: usernameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: principleRowLabel.intrinsicContentSize.width, height: principleRowLabel.intrinsicContentSize.height)
                principleCollectionView.anchor(top: principleRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 320)
            }
            
        case false:
            principleRowLabel.anchor(top: stepCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: principleRowLabel.intrinsicContentSize.width, height: principleRowLabel.intrinsicContentSize.height)
            principleCollectionView.anchor(top: principleRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 320)
        }
        
    }
    
    func setupEmptyCheck(){
        if usernameLabel.text == nil {
            if steps.isEmpty && principles.isEmpty {
                addSubview(emptyLabel)
                emptyLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: emptyLabel.intrinsicContentSize.height)
                emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupStepCollection()
//        setupPrincipleCollection()
        setupSampleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
