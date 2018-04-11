//
//  HomePursuits.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomePursuitsRowDelegate {
    func pursuitClicked()
    func pursuitHeld()
}

class HomeSteps : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PursuitSelected {
    
    var pursuitsDelegate : HomePursuitsRowDelegate?
    var accessHomeController : HomeContainer?
    let homeCellId = "homeCellId"
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Steps"
        label.textAlignment = .left
        return label
    }()
    
    let homeImageNames = ["movie-app", "messenger-app", "workout", "wim-hof", "meditation"]
    let homePursuitDescriptions = ["Movie App", "Messenger App", "Gain 15 Pounds", "Wim Hof Breathing", "Guided Meditation"]
    
    let homePursuitsCollection : UICollectionView = {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomeStepCells
        cell.pursuitImage.image = UIImage(named: homeImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.pursuitLabel.text = homePursuitDescriptions[indexPath.item]
        cell.delegate = self
        return cell
    }
    
     func setupView() {
        addSubview(rowLabel)
        
        setupIntroView()
        
        addSubview(homePursuitsCollection)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        homePursuitsCollection.anchor(top: grayBox.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 355)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        homePursuitsCollection.register(HomeStepCells.self, forCellWithReuseIdentifier: homeCellId)
        homePursuitsCollection.delegate = self
        homePursuitsCollection.dataSource = self
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
        
        grayBox.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 150)
        stepDescriptionLabel.anchor(top: grayBox.topAnchor, left: grayBox.leftAnchor, bottom: nil, right: grayBox.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 80)
        underlineView.anchor(top: stepDescriptionLabel.bottomAnchor, left: grayBox.leftAnchor, bottom: nil, right: grayBox.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        gotItButton.anchor(top: nil, left: nil, bottom: grayBox.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: gotItButton.intrinsicContentSize.width, height: gotItButton.intrinsicContentSize.height)
        gotItButton.centerXAnchor.constraint(equalTo: grayBox.centerXAnchor).isActive = true
        
    }
    
}
