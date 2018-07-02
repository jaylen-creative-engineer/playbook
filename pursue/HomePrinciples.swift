//
//  HomePrinciples.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomePrinciplesDelegate {
    func principleTapped()
    func principleHeld()
}

class HomePrinciples : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var principlesDelegate : HomePrinciplesDelegate?
    var accessHomeController : HomeContainer?
    
    let profileImageNames = ["realist", "inheritance", "value-first", "menu-numbers"]
    let profileLabelText = ["Naive Realism", "Treat others like they control your inheritance","Show value upfront", "Organize and label menu categories"]
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let principleCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePrinciplesCells
        rowLabel.text = "Principles"
//        cell.principleLabel.text = profileLabelText[indexPath.item]
//        cell.principleImage.image = UIImage(named: profileImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func principleTapped() {
//        delegate?.profilePrincipleTapped()
    }
    
    func principleHeld() {
//        delegate?.profilePrincipleHeld()
    }
    
    func setupView(){
        addSubview(rowLabel)
        
        setupIntroView()
        addSubview(principleCollection)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        principleCollection.anchor(top: grayBox.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        principleCollection.showsVerticalScrollIndicator = false
        principleCollection.register(HomePrinciplesCells.self, forCellWithReuseIdentifier: cellId)
        principleCollection.dataSource = self
        principleCollection.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
