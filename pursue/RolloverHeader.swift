//
//  RolloverHeader.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/11/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit
import EasyTipView

class RolloverHeader : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, EasyTipViewDelegate {
    
    let viewsBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.rgb(red: 189, green: 190, blue: 195)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        return button
    }()
    
    let viewsCount : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "30 Views"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let viewsStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = 10
        return sv
    }()
    
    let saveBackground : UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.75
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        return button
    }()
    
    let saveLabel : UILabel = {
        let label = UILabel()
        label.text = "Save"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let saveStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = 10
        return sv
    }()
    
    let tryBackground : UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.75
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        return button
    }()
    
    let tryLabel : UILabel = {
        let label = UILabel()
        label.text = "Try"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let tryStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = 10
        return sv
    }()
    
    let optionsBackground : UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.75
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        return button
    }()
    
    let optionsLabel : UILabel = {
        let label = UILabel()
        label.text = "Options"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let optionsStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = 10
        return sv
    }()
    
    let engagementsStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 42.8
        return sv
    }()
    
    let pullIndicator : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "This is a placeholder description"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let viewImage : UIButton = {
       let button = UIButton(type: .system)
        button.tintColor = UIColor.rgb(red: 98, green: 98, blue: 98)
        button.setImage(UIImage(named : "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let saveImage : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.black
        button.setImage(UIImage(named : "bookmark_outline")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let tryImage : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.black
        button.setImage(UIImage(named : "try-icon-black")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let optionsImage : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.black
        button.setImage(UIImage(named : "gear")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    var preferences = EasyTipView.Preferences()
    
    func setupTipView(){
        preferences.drawing.font = UIFont.boldSystemFont(ofSize: 12)
        preferences.drawing.foregroundColor = .white
        preferences.drawing.backgroundColor = .black
        preferences.drawing.cornerRadius = 14
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        preferences.drawing.arrowHeight = 1.5
        preferences.drawing.arrowWidth = 1.5
        preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: 15)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 1.5
        preferences.animating.dismissDuration = 1.5
        
        let tipView = EasyTipView(text: "Give this pursuit a try for yourself.", preferences: preferences, delegate: self)
        tipView.show(forView: tryStackView, withinSuperview: self)
        insertSubview(tipView, aboveSubview: collectionView)
        tipView.anchor(top: tryStackView.bottomAnchor, left: tryStackView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 225, height: 50)
    }
    
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        tipView.dismiss()
    }
    
    func addImagesToEngagements(){
        addSubview(viewImage)
        addSubview(saveImage)
        addSubview(tryImage)
        addSubview(optionsImage)
        
        viewImage.centerXAnchor.constraint(equalTo: viewsBackground.centerXAnchor).isActive = true
        viewImage.centerYAnchor.constraint(equalTo: viewsBackground.centerYAnchor).isActive = true
        viewImage.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 22)
        saveImage.centerXAnchor.constraint(equalTo: saveBackground.centerXAnchor).isActive = true
        saveImage.centerYAnchor.constraint(equalTo: saveBackground.centerYAnchor).isActive = true
        saveImage.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 18, height: 22)
        tryImage.centerXAnchor.constraint(equalTo: tryBackground.centerXAnchor).isActive = true
        tryImage.centerYAnchor.constraint(equalTo: tryBackground.centerYAnchor).isActive = true
        tryImage.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        optionsImage.centerXAnchor.constraint(equalTo: optionsBackground.centerXAnchor).isActive = true
        optionsImage.centerYAnchor.constraint(equalTo: optionsBackground.centerYAnchor).isActive = true
        optionsImage.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
    }
    
    func setupEngagements(){
        viewsStackView.addArrangedSubview(viewsBackground)
        viewsStackView.addArrangedSubview(viewsCount)
        
        saveStackView.addArrangedSubview(saveBackground)
        saveStackView.addArrangedSubview(saveLabel)
        
        tryStackView.addArrangedSubview(tryBackground)
        tryStackView.addArrangedSubview(tryLabel)
        
        optionsStackView.addArrangedSubview(optionsBackground)
        optionsStackView.addArrangedSubview(optionsLabel)
        
        addSubview(engagementsStackView)
        engagementsStackView.addArrangedSubview(viewsStackView)
        engagementsStackView.addArrangedSubview(saveStackView)
        engagementsStackView.addArrangedSubview(tryStackView)
        engagementsStackView.addArrangedSubview(optionsStackView)
        engagementsStackView.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 99)
        addImagesToEngagements()
    }
    
    func setupDetailsBottom(){
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: pullIndicator.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 28, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 70).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupView(){
        addSubview(pullIndicator)
        pullIndicator.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 5)
        pullIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        setupDetailsBottom()
        setupEngagements()
    }
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let cellId = "cellId"
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RolloverDay.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.anchor(top: engagementsStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        setupCollectionView()
        setupTipView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RolloverDay
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 18)
    }
}

