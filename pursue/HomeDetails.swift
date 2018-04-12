//
//  HomeDetails.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/11/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeDetails : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PursuitSelected {
    
    var pursuitsDelegate : HomePursuitsRowDelegate?
    var accessHomeController : HomeContainer?
    let homeCellId = "homeCellId"
    
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
    
    let homeImageNames = ["movie-app", "messenger-app", "workout", "wim-hof", "meditation"]
    let homePursuitDescriptions = ["Movie App", "Messenger App", "Gain 15 Pounds", "Wim Hof Breathing", "Guided Meditation"]
    
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
    
    func pursuitTapped() {
        pursuitsDelegate?.pursuitClicked()
    }
    
    func pursuitHeld() {
        pursuitsDelegate?.pursuitHeld()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
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
            cell.pursuitImage.image = UIImage(named: homeImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
            cell.pursuitLabel.text = homePursuitDescriptions[indexPath.item]
            cell.delegate = self
            return cell
        case principleCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciplesCells
            cell.principleLabel.text = homePursuitDescriptions[indexPath.item]
            cell.principleImage.image = UIImage(named: homeImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
            return cell
        case addedCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! HomePeopleCells
            cell.usernameLabel.text = homePursuitDescriptions[indexPath.item]
            cell.profileImage.image = UIImage(named: homeImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
            return cell
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    let stepId = "stepId"
    let principleId = "principleId"
    let peopleId = "peopleId"
    
    func setupStepView(){
        stepsCollection.delegate = self
        stepsCollection.dataSource = self
        stepsCollection.register(HomeStepCells.self, forCellWithReuseIdentifier: stepId)
        
        addSubview(stepRowLabel)
        addSubview(stepsCollection)
        
        setupIntroView()
        
        stepRowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: stepRowLabel.intrinsicContentSize.width, height: stepRowLabel.intrinsicContentSize.height)
        stepsCollection.anchor(top: grayBox.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
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
        
        principleRowLabel.anchor(top: stepsCollection.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: principleRowLabel.intrinsicContentSize.width, height: principleRowLabel.intrinsicContentSize.height)
        principleCollection.anchor(top: principleGrayBox.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
    }
    
    func setupAddedView(){
        addedCollection.delegate = self
        addedCollection.dataSource = self
        addedCollection.register(HomePeopleCells.self, forCellWithReuseIdentifier: peopleId)
        
        addSubview(addedRowLabel)
        addSubview(addedCollection)
        
        addedSetupIntroView()
        
        addedRowLabel.anchor(top: principleCollection.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: addedRowLabel.intrinsicContentSize.width, height: addedRowLabel.intrinsicContentSize.height)
        addedCollection.anchor(top: addedGrayBox.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStepView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    let gotItButton : UIButton = {
        let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let underlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
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
    
    let principleGotItButton : UIButton = {
        let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let principleUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
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
    
    let addedGotItButton : UIButton = {
        let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let addedUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
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
