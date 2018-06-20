//
//  HomeRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import iCarousel

protocol HomeRowImageEngagements {
    func homeRowScrolled(for cell : HomeRow)
}

class HomeRow: UICollectionViewCell {
    
    var home : Home? {
        didSet {
            guard let data = self.home?.pursuit_array else { return }
            data.forEach { (value) in
                self.postContent.append(value)
            }
            self.user = home?.user
            
            if home?.steps != nil {
                let data = (self.home?.steps)!
                data.forEach { (value) in
                    self.steps.append(value)
                }
            }
            
            if home?.principles != nil {
                let principleData = (self.home?.principles)!
                principleData.forEach { (value) in
                    self.principles.append(value)
                }
            }
            
            if home?.searched_users != nil {
                let addedUserData = (self.home?.searched_users)!
                addedUserData.forEach { (value) in
                    self.users.append(value)
                }
            }
            
            self.carouselView.reloadData()
        }
    }
    
    var postContent = [HomePostContent]()
    var steps = [SearchedSteps]()
    var users = [SearchedUsers]()
    var principles = [SearchedPrinciples]()
    var user : User?
    var accessHomeController : HomeContainer?
    var homeDelegate : HomeRowImageEngagements?
    let pursuitId = "pursuitId"
    let principleId = "principleId"
    let stepId = "stepId"
    let peopleId = "peopleId"
    var isLeft = true
    var isRight = true
    var cellIndex : Int = 0
    var count : Int = 0
    var isLiked = false
    
    let stepRowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Steps"
        label.textAlignment = .left
        return label
    }()
    
    let principleRowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Principles"
        label.textAlignment = .left
        return label
    }()
    
    let addedRowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Added"
        label.textAlignment = .left
        return label
    }()
    
    let stepsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let principleCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let addedCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var carouselView : iCarousel = {
        let ic = iCarousel()
        return ic
    }()
    
    lazy var optionButton : UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Setup Step Intro
    
    let grayBox : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 244, green: 244, blue: 244)
        return view
    }()
    
    let stepDescriptionLabel : UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Save the steps that you could you to your pursuits.")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var gotItButton : UIButton = {
        let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(stepSelected), for: .touchUpInside)
        return button
    }()
    
    let underlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Setup Principle Intro
    
    let principleGrayBox : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 244, green: 244, blue: 244)
        return view
    }()
    
    let principleDescriptionLabel : UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Save the steps that you could you to your pursuits.")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var principleGotItButton : UIButton = {
        let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(principleSelected), for: .touchUpInside)
        return button
    }()
    
    let principleUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Setup Added Intro
    
    let addedGrayBox : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 244, green: 244, blue: 244)
        return view
    }()
    
    let addedDescriptionLabel : UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Save the steps that you could you to your pursuits.")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var addedGotItButton : UIButton = {
        let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(addedSelected), for: .touchUpInside)
        return button
    }()
    
    let addedUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let stepsEmpty : UILabel = {
       let label = UILabel()
        label.text = "There are no steps related to this pursuit."
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let principlesEmpty : UILabel = {
       let label = UILabel()
        label.text = "There are no principles related to this pursuit."
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let addedEmpty : UILabel = {
       let label = UILabel()
        label.text = "There are no people added to this purusit."
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    @objc func showOptions(){
        accessHomeController?.optionClicked()
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isPrinciplesDetail")
        case "isPursuitDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail")
        case "isImageDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
        case "isDiscussionDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isDiscussionDetail")
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    func imageView(){
        accessHomeController?.imageView()
    }
    
    @objc func showDetail(){
        accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCarousels()
        setupStepView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageNames = ["fire", "flights", "currency"]
    let labelText = ["Start a fire", "How to find cheaper flights?", "How to read a map?"]
    var fakeFollowerArray = [#imageLiteral(resourceName: "samuel-l"), #imageLiteral(resourceName: "comment-4"), #imageLiteral(resourceName: "comment-5")]
    let usernameList = ["Tom", "James", "John"]
    
}


extension HomeRow : iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
//        return postContent.count
        return 3
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var carouselView = UIView()
        carouselView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 500))
        carouselView.isUserInteractionEnabled = true
        carouselView.backgroundColor = .clear
        
        let postLabel = UILabel()
        postLabel.font = UIFont.boldSystemFont(ofSize: 14)
        postLabel.textAlignment = .justified
        postLabel.numberOfLines = 1
        postLabel.text = labelText[index]
        postLabel.sizeToFit()
        
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        usernameLabel.textAlignment = .justified
        usernameLabel.numberOfLines = 1
        usernameLabel.text = usernameList[index]
        usernameLabel.sizeToFit()
        
        let profilePicture = UIImageView()
        profilePicture.contentMode = .scaleAspectFill
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.layer.cornerRadius = 25
        profilePicture.layer.masksToBounds = true
        profilePicture.backgroundColor = .red
        profilePicture.image = fakeFollowerArray[index]
        
        let carouselImage = UIImageView()
        carouselImage.contentMode = .scaleAspectFill
        carouselImage.layer.cornerRadius = 4
        carouselImage.layer.masksToBounds = true
        carouselImage.isUserInteractionEnabled = true
        carouselImage.image = UIImage(named: imageNames[index])
        carouselImage.backgroundColor = .red
        
        let leftButton = UIButton()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.isUserInteractionEnabled = true
        leftButton.addTarget(self, action: #selector(handleLeftTap), for: .touchUpInside)
        
        let rightButton = UIButton()
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.isUserInteractionEnabled = true
        rightButton.addTarget(self, action: #selector(handleRightTap), for: .touchUpInside)
        
        let playBackground = PlayView()
        playBackground.layer.cornerRadius = 15
        playBackground.translatesAutoresizingMaskIntoConstraints = false
        playBackground.backgroundColor = .white
        playBackground.layer.masksToBounds = true
        
        let playIcon = UIImageView()
        playIcon.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
        playIcon.contentMode = .scaleAspectFill
        playIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundButton = UIButton()
        backgroundButton.backgroundColor = .white
        backgroundButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundButton.layer.cornerRadius = 2
        backgroundButton.clipsToBounds = true
        backgroundButton.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
        
        let fullscreenLabel = UILabel()
        fullscreenLabel.text = "Full Screen"
        fullscreenLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(25))
        fullscreenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        carouselView.addSubview(carouselImage)
        carouselView.addSubview(leftButton)
        carouselView.addSubview(rightButton)
        carouselView.addSubview(backgroundButton)
        carouselView.addSubview(fullscreenLabel)
        carouselView.addSubview(playBackground)
        carouselView.addSubview(playIcon)
        carouselView.addSubview(postLabel)
        carouselView.addSubview(usernameLabel)
        carouselView.addSubview(profilePicture)
        
        carouselImage.anchor(top: carouselView.topAnchor, left: carouselView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 28, paddingBottom: 0, paddingRight: 0, width: 325, height: 405)
        leftButton.anchor(top: carouselImage.topAnchor, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        rightButton.anchor(top: carouselImage.topAnchor, left: carouselImage.centerXAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backgroundButton.anchor(top: nil, left: leftButton.leftAnchor, bottom: leftButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: 100, height: 30)
        fullscreenLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: fullscreenLabel.intrinsicContentSize.width, height: fullscreenLabel.intrinsicContentSize.height)
        fullscreenLabel.centerXAnchor.constraint(equalTo: backgroundButton.centerXAnchor).isActive = true
        fullscreenLabel.centerYAnchor.constraint(equalTo: backgroundButton.centerYAnchor).isActive = true
        playBackground.anchor(top: nil, left: nil, bottom: rightButton.bottomAnchor, right: rightButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 30, height: 30)
        playIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        playIcon.centerXAnchor.constraint(equalTo: playBackground.centerXAnchor).isActive = true
        playIcon.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
        profilePicture.anchor(top: carouselImage.bottomAnchor, left: carouselImage.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        postLabel.anchor(top: profilePicture.topAnchor, left: profilePicture.rightAnchor, bottom: nil, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: postLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        
        if !postContent.isEmpty {
            guard let photo = postContent[index].thumbnailUrl else { return carouselView }
            carouselImage.loadImageUsingCacheWithUrlString(photo)
            postLabel.text = postContent[index].description
            usernameLabel.text = user?.username
            guard let profileImage = user?.photoUrl else { return carouselView }
            profilePicture.loadImageUsingCacheWithUrlString(profileImage)
            
        }
        
        return carouselView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 0.8
        }
        
        return value
    }
    
    func carouselDidScroll(_ carousel: iCarousel) {
        if carousel == carouselView {
            homeDelegate?.homeRowScrolled(for: self)
        }
    }
    
    @objc func handleLeftTap(){
        carouselView.scrollToItem(at: cellIndex - 1, animated: true)
        cellIndex = cellIndex - 1
        
        if cellIndex < 0 {
            cellIndex = cellIndex + 1
        }
    }
    
    @objc func handleRightTap(){
        carouselView.scrollToItem(at: cellIndex + 1, animated: true)
        cellIndex = cellIndex + 1
        
        if cellIndex > postContent.count {
            cellIndex = cellIndex - 1
        }
    }
    
    func setupCarousels(){
        setupStandardCarousel()
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        let currentIndex = carouselView.currentItemIndex
        cellIndex = currentIndex
    }
    
    func setupStandardCarousel(){
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.type = .invertedTimeMachine
        
        addSubview(carouselView)
        addSubview(optionButton)
        carouselView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 475)
        optionButton.anchor(top: nil, left: nil, bottom: carouselView.bottomAnchor, right: carouselView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 42, paddingRight: 12, width: optionButton.intrinsicContentSize.width, height: optionButton.intrinsicContentSize.height)
    }
    
    func setupStepView(){
        stepsCollection.delegate = self
        stepsCollection.dataSource = self
        stepsCollection.register(HomeStepCells.self, forCellWithReuseIdentifier: stepId)
        
        addSubview(stepRowLabel)
        addSubview(stepsCollection)
        
        setupIntroView()
        
        if UserDefaults.standard.value(forKey: "stepDescription") != nil {
            grayBox.isHidden = true
            stepDescriptionLabel.isHidden = true
            underlineView.isHidden = true
            gotItButton.isHidden = true
            stepRowLabel.anchor(top: carouselView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: stepRowLabel.intrinsicContentSize.width, height: stepRowLabel.intrinsicContentSize.height)
            stepsCollection.anchor(top: stepRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
            
            if steps.isEmpty {
                addSubview(stepsEmpty)
                stepsEmpty.anchor(top: stepRowLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: stepsEmpty.intrinsicContentSize.width, height: 50)
                stepsEmpty.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        } else {
            stepRowLabel.anchor(top: carouselView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: stepRowLabel.intrinsicContentSize.width, height: stepRowLabel.intrinsicContentSize.height)
            stepsCollection.anchor(top: grayBox.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
            
            if steps.isEmpty {
                addSubview(stepsEmpty)
                stepsEmpty.anchor(top: stepRowLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: stepsEmpty.intrinsicContentSize.width, height: 50)
                stepsEmpty.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        }
        setupPrincipleView()
        setupAddedView()
    }
    
    func setupPrincipleView(){
        principleCollection.delegate = self
        principleCollection.dataSource = self
        principleCollection.register(HomePrinciplesCells.self, forCellWithReuseIdentifier: principleId)
        
        addSubview(principleRowLabel)
        addSubview(principleCollection)
        
        principleSetupIntroView()
        
        if UserDefaults.standard.value(forKey: "principleDescription") != nil {
            principleGrayBox.isHidden = true
            principleDescriptionLabel.isHidden = true
            principleUnderlineView.isHidden = true
            principleGotItButton.isHidden = true
            principleRowLabel.anchor(top: stepsCollection.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: principleRowLabel.intrinsicContentSize.width, height: principleRowLabel.intrinsicContentSize.height)
            principleCollection.anchor(top: principleRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
            
            if principles.isEmpty {
                addSubview(principlesEmpty)
                principlesEmpty.anchor(top: principleRowLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: principlesEmpty.intrinsicContentSize.width, height: 50)
                principlesEmpty.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        } else {
            principleRowLabel.anchor(top: stepsCollection.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: principleRowLabel.intrinsicContentSize.width, height: principleRowLabel.intrinsicContentSize.height)
            principleCollection.anchor(top: principleGrayBox.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
            
            if principles.isEmpty {
                addSubview(principlesEmpty)
                principlesEmpty.anchor(top: principleRowLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: principlesEmpty.intrinsicContentSize.width, height: 50)
                principlesEmpty.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        }
    }
    
    func setupAddedView(){
        addedCollection.delegate = self
        addedCollection.dataSource = self
        addedCollection.register(HomePeopleCells.self, forCellWithReuseIdentifier: peopleId)
        
        addSubview(addedRowLabel)
        addSubview(addedCollection)
        
        addedSetupIntroView()
        
        if UserDefaults.standard.value(forKey: "addedDescription") != nil {
            addedGrayBox.isHidden = true
            addedDescriptionLabel.isHidden = true
            addedUnderlineView.isHidden = true
            addedGotItButton.isHidden = true
            addedRowLabel.anchor(top: principleCollection.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: addedRowLabel.intrinsicContentSize.width, height: addedRowLabel.intrinsicContentSize.height)
            addedCollection.anchor(top: addedRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
            
            if users.isEmpty {
                addSubview(addedEmpty)
                addedEmpty.anchor(top: addedRowLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: addedEmpty.intrinsicContentSize.width, height: 50)
                addedEmpty.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
            
        } else {
            addedRowLabel.anchor(top: principleCollection.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: addedRowLabel.intrinsicContentSize.width, height: addedRowLabel.intrinsicContentSize.height)
            addedCollection.anchor(top: addedGrayBox.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
            
            if users.isEmpty {
                addSubview(addedEmpty)
                addedEmpty.anchor(top: addedRowLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: addedEmpty.intrinsicContentSize.width, height: 50)
                addedEmpty.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        }
    }
    
    func setupIntroView(){
        addSubview(grayBox)
        addSubview(stepDescriptionLabel)
        addSubview(underlineView)
        addSubview(gotItButton)
        
        grayBox.anchor(top: stepRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 150)
        stepDescriptionLabel.anchor(top: grayBox.topAnchor, left: grayBox.leftAnchor, bottom: nil, right: grayBox.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 80)
        underlineView.anchor(top: stepDescriptionLabel.bottomAnchor, left: grayBox.leftAnchor, bottom: nil, right: grayBox.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        gotItButton.anchor(top: nil, left: nil, bottom: grayBox.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: gotItButton.intrinsicContentSize.width, height: gotItButton.intrinsicContentSize.height)
        gotItButton.centerXAnchor.constraint(equalTo: grayBox.centerXAnchor).isActive = true
        
    }
    
    @objc func stepSelected(){
        UserDefaults.standard.set("true", forKey: "stepDescription")
        grayBox.isHidden = true
        stepDescriptionLabel.isHidden = true
        underlineView.isHidden = true
        gotItButton.isHidden = true
    }
    
    @objc func principleSelected(){
        UserDefaults.standard.set("true", forKey: "principleDescription")
        principleGrayBox.isHidden = true
        principleDescriptionLabel.isHidden = true
        principleUnderlineView.isHidden = true
        principleGotItButton.isHidden = true
    }
    
    func principleSetupIntroView(){
        addSubview(principleGrayBox)
        addSubview(principleDescriptionLabel)
        addSubview(principleUnderlineView)
        addSubview(principleGotItButton)
        
        principleGrayBox.anchor(top: principleRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 150)
        principleDescriptionLabel.anchor(top: principleGrayBox.topAnchor, left: principleGrayBox.leftAnchor, bottom: nil, right: principleGrayBox.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 80)
        principleUnderlineView.anchor(top: principleDescriptionLabel.bottomAnchor, left: principleGrayBox.leftAnchor, bottom: nil, right: principleGrayBox.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        principleGotItButton.anchor(top: nil, left: nil, bottom: principleGrayBox.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: principleGotItButton.intrinsicContentSize.width, height: principleGotItButton.intrinsicContentSize.height)
        principleGotItButton.centerXAnchor.constraint(equalTo: principleGrayBox.centerXAnchor).isActive = true
    }
    
    @objc func addedSelected(){
        UserDefaults.standard.set("true", forKey: "addedDescription")
        addedGrayBox.isHidden = true
        addedDescriptionLabel.isHidden = true
        addedUnderlineView.isHidden = true
        addedGotItButton.isHidden = true
    }
    
    func addedSetupIntroView(){
        addSubview(addedGrayBox)
        addSubview(addedDescriptionLabel)
        addSubview(addedUnderlineView)
        addSubview(addedGotItButton)
        
        addedGrayBox.anchor(top: addedRowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 150)
        addedDescriptionLabel.anchor(top: addedGrayBox.topAnchor, left: addedGrayBox.leftAnchor, bottom: nil, right: addedGrayBox.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 80)
        addedUnderlineView.anchor(top: addedDescriptionLabel.bottomAnchor, left: addedGrayBox.leftAnchor, bottom: nil, right: addedGrayBox.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        addedGotItButton.anchor(top: nil, left: nil, bottom: addedGrayBox.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: addedGotItButton.intrinsicContentSize.width, height: addedGotItButton.intrinsicContentSize.height)
        addedGotItButton.centerXAnchor.constraint(equalTo: addedGrayBox.centerXAnchor).isActive = true
    }
}

extension HomeRow : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case stepsCollection:
            return steps.count
        case principleCollection:
            return principles.count
        case addedCollection:
            return users.count
        default:
            return users.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case stepsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! HomeStepCells
            cell.step = steps[indexPath.item]
            return cell
        case principleCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciplesCells
            cell.principle = principles[indexPath.item]
            return cell
        case addedCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! HomePeopleCells
            cell.user = users[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! HomePeopleCells
            cell.user = users[indexPath.item]
            return cell
        }
    }
}
