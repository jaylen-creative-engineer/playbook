//
//  PursuitCards.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PursuitDelegate {
    func pursuitSelected(for cell : PursuitTodayPrimaryCard)
}
class PursuitTodayPrimaryCard: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var delegate : PursuitDelegate?
    var pursuitsController : PursuitsController?
    
    let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "TODAY"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let teamLabel : UILabel = {
        let label = UILabel()
        label.text = "Team"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let toolLabel : UILabel = {
        let label = UILabel()
        label.text = "Tool"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let cardInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "Design"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let catchUpLabel : UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let pictureOverlay : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let exerciseCard : CardView = {
       let view = CardView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var cardImage : UIButton = {
       let iv = UIButton()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setImage(#imageLiteral(resourceName: "tumblr_nbje6dualg1r46py4o1_1280"), for: .normal)
        iv.addTarget(self, action: #selector(exercisePressed), for: .touchUpInside)
        return iv
    }()
    
    let execeriseLabel : UILabel = {
        let label = UILabel()
        label.text = "Draw"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let execeriseCompletedLabel : UILabel = {
        let label = UILabel()
        label.text = "123,456 Completions •"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        return label
    }()
    
    let execeriseTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "01:23:45"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        return label
    }()
    
    let profilePicture : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 30
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "tumblr_nbj794TLRx1r46py4o1_1280")
        return iv
    }()
    
    let teamAndToolsCollectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = teamAndToolsCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PursuitAddons
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.width + 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    @objc func exercisePressed() {
        delegate?.pursuitSelected(for: self)
    }
    
    func setupCardDetails(){
        addSubview(execeriseLabel)
        addSubview(execeriseCompletedLabel)
        addSubview(execeriseTimeLabel)
        
        execeriseLabel.anchor(top: cardImage.bottomAnchor, left: cardImage.leftAnchor, bottom: nil, right: cardImage.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
        execeriseCompletedLabel.anchor(top: execeriseLabel.bottomAnchor, left: execeriseLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 16)
        execeriseTimeLabel.anchor(top: execeriseCompletedLabel.topAnchor, left: execeriseCompletedLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 16)
    }
    
    func setupTitleForCardView(){
        addSubview(titleLabel)
        addSubview(catchUpLabel)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 20)
        catchUpLabel.anchor(top: titleLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 90, height: 20)
    }
    
    func setupTeamAndTools(){
        addSubview(teamAndToolsCollectionView)
        
        teamAndToolsCollectionView.anchor(top: execeriseCompletedLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    func setupCardView(){
        setupTitleForCardView()
        
        addSubview(cardImage)
        
        cardImage.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: catchUpLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 210)
        
        setupCardDetails()
        setupTeamAndTools()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardView()
        teamAndToolsCollectionView.delegate = self
        teamAndToolsCollectionView.dataSource = self
        teamAndToolsCollectionView.register(PursuitAddons.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
